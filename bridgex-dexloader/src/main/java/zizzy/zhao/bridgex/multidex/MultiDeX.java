package zizzy.zhao.bridgex.multidex;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import org.json.JSONObject;

import java.io.Closeable;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.zip.ZipFile;

import dalvik.system.DexFile;

public class MultiDeX {

    private static final String TAG = "MultiDeX";
    private static final String CODE_CACHE_SECONDARY_FOLDER_NAME = "secondary-dexes";
    private static AtomicBoolean installed = new AtomicBoolean(false);
    private static final int MAX_SUPPORTED_SDK_VERSION = 20;
    private static final int MIN_SDK_VERSION = 4;
    private static final Set<String> installedApk = new HashSet<>();
    private static final String LOCK_FILENAME = "MultiDex.lock";
    private static RandomAccessFile lockRaf;
    private static FileChannel lockChannel;
    private static FileLock cacheLock;
    private static long starttime;
    private static long endtime;

    private MultiDeX() {
    }

    static {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            HiddenApiWrapper.exemptAll();
        }
    }

    public static void install(Context context) {
        Log.i(TAG, "install begin ...");
        if (installed.get()) {
            Log.i(TAG, "installed");
            return;
        }

        if (Build.VERSION.SDK_INT < MIN_SDK_VERSION) {
            throw new RuntimeException("Multi dex installation failed. SDK "
                    + Build.VERSION.SDK_INT
                    + " is unsupported. Min SDK version is " + MIN_SDK_VERSION
                    + ".");
        }

        starttime = System.currentTimeMillis();

        Context ctx = context.getApplicationContext() == null ? context : context.getApplicationContext();
        String assetsDexDir = null;
        boolean forceClearOldDexCache = false;
        InputStream is = null;
        try {
            is = ctx.getResources().getAssets().open("bridgex_conf.json");
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);

            JSONObject json = new JSONObject(new String(buffer)).optJSONObject("multi_dex");
            if (json == null) {
                throw new IllegalArgumentException("Oops!!! No configuration: multi_dex.");
            }
            assetsDexDir = json.optString("assets_dex_dir");
            forceClearOldDexCache = json.optBoolean("force_clear_old_dex_cache");
        } catch (Throwable th) {
            Log.e(TAG, "parse bridgex_conf.json error: " + th);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                }
            }
        }

        if (forceClearOldDexCache) {
            try {
                clearOldDexDir(ctx);
            } catch (Exception e) {
                Log.w(TAG, "Something went wrong when trying to clear old MultiDex extraction, "
                        + "continuing without cleaning.", e);
            }
        }

        AssetsManager.copyAllAssetsApk(ctx, CODE_CACHE_SECONDARY_FOLDER_NAME, assetsDexDir);
        Log.d(TAG, "SDK_INT: " + Build.VERSION.SDK_INT);

        try {
            ApplicationInfo applicationInfo = getApplicationInfo(ctx);
            if (applicationInfo == null) {
                // Looks like running on a test Context, so just return without
                // patching.
                return;
            }
            synchronized (installedApk) {
                String apkPath = applicationInfo.sourceDir;
                if (installedApk.contains(apkPath)) {
                    return;
                }
                installedApk.add(apkPath);
                if (Build.VERSION.SDK_INT > MAX_SUPPORTED_SDK_VERSION) {
                    Log.w(TAG, "MultiDex is not guaranteed to work in SDK version "
                            + Build.VERSION.SDK_INT
                            + ": SDK version higher than "
                            + MAX_SUPPORTED_SDK_VERSION
                            + " should be backed by "
                            + "runtime with built-in multidex capabilty but it's not the "
                            + "case here: java.vm.version=\""
                            + System.getProperty("java.vm.version")
                            + "\"");
                }
                /*
                 * The patched class loader is expected to be a descendant of
                 * dalvik.system.BaseDexClassLoader. We modify its
                 * dalvik.system.DexPathList pathList field to append additional
                 * DEX file entries.
                 */
                ClassLoader loader;
                try {
                    loader = ctx.getClassLoader();
                } catch (RuntimeException e) {
                    /*
                     * Ignore those exceptions so that we don't break tests
                     * relying on Context like a android.test.mock.MockContext
                     * or a android.content.ContextWrapper with a null base
                     * Context.
                     */
                    throw new Exception("Failure while trying to obtain Context class loader. "
                            + "Must be running in test mode. Skip patching. " + e);
                }
                if (loader == null) {
                    // Note, the context class loader is null when running
                    // Robolectric tests.
                    throw new Exception("Context class loader is null. Must be running in test mode. "
                            + "Skip patching.");
                }

                // 获取dex文件列表
                File dexDir = ctx.getDir(CODE_CACHE_SECONDARY_FOLDER_NAME, Context.MODE_PRIVATE);
                File[] szFiles = dexDir.listFiles(new FilenameFilter() {
                    @Override
                    public boolean accept(File dir, String filename) {
                        return filename.endsWith(AssetsManager.FILE_FILTER);
                    }
                });

                File lockFile = new File(dexDir, LOCK_FILENAME);
                lockRaf = new RandomAccessFile(lockFile, "rw");
                try {
                    lockChannel = lockRaf.getChannel();
                    try {
                        Log.i(TAG, "Blocking on lock " + lockFile.getPath());
                        cacheLock = lockChannel.lock();
                    } catch (IOException | RuntimeException | Error e) {
                        closeQuietly(lockChannel);
                        throw e;
                    }
                    Log.i(TAG, lockFile.getPath() + " locked");
                } catch (IOException | RuntimeException | Error e) {
                    closeQuietly(lockRaf);
                    throw e;
                }

                List<File> files = new ArrayList<>();
                for (File f : szFiles) {
                    Log.v(TAG, "load file [" + f.getName() + "] with md5(" + MD5.getFileMD5(f) + ")");
                    files.add(f);
                }

                IOException closeException = null;
                try {
                    if (!cacheLock.isValid()) {
                        throw new IllegalStateException("MultiDexExtractor was closed");
                    }

                    Log.d(TAG, "loader before: " + ctx.getClassLoader());
                    installSecondaryDexes(loader, dexDir, files);
                    Log.d(TAG, "loader end: " + ctx.getClassLoader());
                } finally {
                    try {
                        cacheLock.release();
                        lockChannel.close();
                        lockRaf.close();
                    } catch (IOException e) {
                        // Delay throw of close exception to ensure we don't override some exception
                        // thrown during the try block.
                        closeException = e;
                    }
                }
                if (closeException != null) {
                    throw closeException;
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "Multi dex installation failed (" + e.getMessage() + ").");
        }
        installed.set(true);
        endtime = System.currentTimeMillis();
        Log.i(TAG, "install done!!!");
        Log.i(TAG, "###### install multidex cost " + (endtime - starttime) + "ms");
    }

//    private static ApplicationInfo getApplicationInfo(Context context) throws Exception {
//        PackageManager pm;
//        String packageName;
//        try {
//            pm = context.getPackageManager();
//            packageName = context.getPackageName();
//        } catch (Exception e) {
//            /*
//             * Ignore those exceptions so that we don't break tests relying on
//             * Context like a android.test.mock.MockContext or a
//             * android.content.ContextWrapper with a null base Context.
//             */
//            throw new Exception("Failure while trying to obtain ApplicationInfo from Context. "
//                    + "Must be running in test mode. Skip patching. " + e);
//        }
//        if (pm == null || packageName == null) {
//            // This is most likely a mock context, so just return without
//            // patching.
//            return null;
//        }
//        return pm.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
//    }

    private static ApplicationInfo getApplicationInfo(Context context) {
        try {
            /* Due to package install races it is possible for a process to be started from an old
             * apk even though that apk has been replaced. Querying for ApplicationInfo by package
             * name may return information for the new apk, leading to a runtime with the old main
             * dex file and new secondary dex files. This leads to various problems like
             * ClassNotFoundExceptions. Using context.getApplicationInfo() should result in the
             * process having a consistent view of the world (even if it is of the old world). The
             * package install races are eventually resolved and old processes are killed.
             */
            return context.getApplicationInfo();
        } catch (RuntimeException e) {
            /* Ignore those exceptions so that we don't break tests relying on Context like
             * a android.test.mock.MockContext or a android.content.ContextWrapper with a null
             * base Context.
             */
            Log.w(TAG, "Failure while trying to obtain ApplicationInfo from Context. " +
                    "Must be running in test mode. Skip patching.", e);
            return null;
        }
    }

    private static void installSecondaryDexes(ClassLoader loader, File dexDir, List<File> files)
            throws IllegalArgumentException, IllegalAccessException, NoSuchFieldException,
            InvocationTargetException, NoSuchMethodException, IOException {
        if (!files.isEmpty()) {
            if (Build.VERSION.SDK_INT >= 19) {
                V19.install(loader, files, dexDir);
            } else if (Build.VERSION.SDK_INT >= 14) {
                V14.install(loader, files, dexDir);
            } else {
                V4.install(loader, files);
            }
        }
    }

    /**
     * Locates a given field anywhere in the class inheritance hierarchy.
     *
     * @param instance an object to search the field into.
     * @param name     field name
     * @return a field object
     * @throws NoSuchFieldException if the field cannot be located
     */
    private static Field findField(Object instance, String name) throws NoSuchFieldException {
        for (Class<?> clazz = instance.getClass(); clazz != null; clazz = clazz.getSuperclass()) {
            try {
                Field field = clazz.getDeclaredField(name);

                if (!field.isAccessible()) {
                    field.setAccessible(true);
                }

                return field;
            } catch (NoSuchFieldException e) {
                // ignore and search next
            }
        }

        throw new NoSuchFieldException("Field " + name + " not found in " + instance.getClass());
    }

    /**
     * Locates a given method anywhere in the class inheritance hierarchy.
     *
     * @param instance       an object to search the method into.
     * @param name           method name
     * @param parameterTypes method parameter types
     * @return a method object
     * @throws NoSuchMethodException if the method cannot be located
     */
    private static Method findMethod(Object instance, String name, Class<?>... parameterTypes)
            throws NoSuchMethodException {
        for (Class<?> clazz = instance.getClass(); clazz != null; clazz = clazz.getSuperclass()) {
            try {
                Method method = clazz.getDeclaredMethod(name, parameterTypes);

                if (!method.isAccessible()) {
                    method.setAccessible(true);
                }

                return method;
            } catch (NoSuchMethodException e) {
                // ignore and search next
            }
        }

        throw new NoSuchMethodException("Method " + name + " with parameters "
                + Arrays.asList(parameterTypes) + " not found in " + instance.getClass());
    }

    /**
     * Replace the value of a field containing a non null array, by a new array
     * containing the elements of the original array plus the elements of
     * extraElements.
     *
     * @param instance      the instance whose field is to be modified.
     * @param fieldName     the field to modify.
     * @param extraElements elements to append at the end of the array.
     */
    private static void expandFieldArray(Object instance, String fieldName, Object[] extraElements)
            throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
        Field jlrField = findField(instance, fieldName);
        Object[] original = (Object[]) jlrField.get(instance);
        Object[] combined = (Object[]) Array.newInstance(original.getClass().getComponentType(),
                original.length + extraElements.length);
        System.arraycopy(original, 0, combined, 0, original.length);
        System.arraycopy(extraElements, 0, combined, original.length, extraElements.length);
        jlrField.set(instance, combined);
    }

    private static void clearOldDexDir(Context context) throws Exception {
        try {
            File dexDir = context.getDir(CODE_CACHE_SECONDARY_FOLDER_NAME, Context.MODE_PRIVATE);
            if (dexDir.isDirectory()) {
                Log.i(TAG, "Clearing old secondary dex dir (" + dexDir.getPath() + ").");
                File[] files = dexDir.listFiles();
                if (files == null) {
                    Log.w(TAG, "Failed to list secondary dex dir content (" + dexDir.getPath() + ").");
                    return;
                }
                for (File oldFile : files) {
                    if (oldFile.isFile() && oldFile.getName().endsWith(".lock")) {
                        continue;
                    }
                    Log.i(TAG, "Trying to delete old file (" + oldFile.getName() + ") of size " + oldFile.length());
                    if (oldFile.isFile() && !oldFile.delete()) {
                        Log.w(TAG, "Failed to delete old file (" + oldFile.getName() + ")");
                    } else {
                        Log.i(TAG, "Success to delete old file (" + oldFile.getName() + ")");
                    }
                }
                if (dexDir.isDirectory() && !dexDir.delete()) {
                    Log.w(TAG, "Failed to delete secondary dex dir (" + dexDir.getName() + ")");
                } else {
                    Log.i(TAG, "Success to delete old secondary dex dir (" + dexDir.getName() + ")");
                }
            }
        } catch (Throwable th) {
            throw new Exception(th);
        }
    }

    static void clearOldDex(Context context, String fileMd5) throws Exception {
        try {
            File dexDir = context.getDir(CODE_CACHE_SECONDARY_FOLDER_NAME, Context.MODE_PRIVATE);
            if (dexDir.isDirectory()) {
                Log.i(TAG, "Clearing old secondary dex in dir (" + dexDir.getPath() + ").");
                File[] files = dexDir.listFiles();
                if (files == null) {
                    Log.w(TAG, "Failed to list secondary dex dir content (" + dexDir.getPath() + ").");
                    return;
                }
                for (File oldFile : files) {
                    if (!oldFile.isFile()) {
                        continue;
                    }
                    if (MD5.getFileMD5(oldFile).equals(fileMd5)) {
                        Log.i(TAG, "Trying to delete old file (" + oldFile.getName() + ") of md5 " + fileMd5);
                        if (!oldFile.delete()) {
                            Log.w(TAG, "Failed to delete old file (" + oldFile.getName() + ")");
                        } else {
                            Log.i(TAG, "Success to delete old file (" + oldFile.getName() + ")");
                        }
                    }
                }
            }
        } catch (Throwable th) {
            throw new Exception(th);
        }
    }

    /**
     * Closes the given {@code Closeable}. Suppresses any IO exceptions.
     */
    private static void closeQuietly(Closeable closeable) {
        try {
            closeable.close();
        } catch (IOException e) {
            Log.w(TAG, "Failed to close resource", e);
        }
    }

    /**
     * Installer for platform versions 19.
     */
    private static final class V19 {

        private static void install(ClassLoader loader, List<File> additionalClassPathEntries,
                                    File optimizedDirectory) throws IllegalArgumentException,
                IllegalAccessException, NoSuchFieldException, InvocationTargetException,
                NoSuchMethodException {
            /*
             * The patched class loader is expected to be a descendant of
             * dalvik.system.BaseDexClassLoader. We modify its
             * dalvik.system.DexPathList pathList field to append additional DEX
             * file entries.
             */
            Field pathListField = findField(loader, "pathList");
            Object dexPathList = pathListField.get(loader);
            ArrayList<IOException> suppressedExceptions = new ArrayList<>();
            expandFieldArray(dexPathList, "dexElements", makeDexElements(dexPathList,
                    new ArrayList<>(additionalClassPathEntries), optimizedDirectory,
                    suppressedExceptions));
            if (suppressedExceptions.size() > 0) {
                for (IOException e : suppressedExceptions) {
                    Log.w(TAG, "Exception in makeDexElement", e);
                }
                Field suppressedExceptionsField = findField(loader,
                        "dexElementsSuppressedExceptions");
                IOException[] dexElementsSuppressedExceptions = (IOException[]) suppressedExceptionsField
                        .get(loader);

                if (dexElementsSuppressedExceptions == null) {
                    dexElementsSuppressedExceptions = suppressedExceptions.toArray(
                            new IOException[suppressedExceptions.size()]);
                } else {
                    IOException[] combined = new IOException[suppressedExceptions.size()
                            + dexElementsSuppressedExceptions.length];
                    suppressedExceptions.toArray(combined);
                    System.arraycopy(dexElementsSuppressedExceptions, 0, combined,
                            suppressedExceptions.size(), dexElementsSuppressedExceptions.length);
                    dexElementsSuppressedExceptions = combined;
                }

                suppressedExceptionsField.set(loader, dexElementsSuppressedExceptions);
            }
        }

        /**
         * A wrapper around
         * {@code private static final dalvik.system.DexPathList#makeDexElements}
         * .
         */
        private static Object[] makeDexElements(Object dexPathList, ArrayList<File> files,
                                                File optimizedDirectory,
                                                ArrayList<IOException> suppressedExceptions)
                throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
//            Method makeDexElements = findMethod(dexPathList, "makeDexElements",
//                    ArrayList.class, File.class, ArrayList.class);
            Method makeDexElements = Build.VERSION.SDK_INT >= 23 ?
                    findMethod(dexPathList, "makePathElements", List.class, File.class, List.class) :
                    findMethod(dexPathList, "makeDexElements", ArrayList.class, File.class, ArrayList.class);

            return (Object[]) makeDexElements.invoke(dexPathList, files, optimizedDirectory,
                    suppressedExceptions);
        }
    }

    /**
     * Installer for platform versions 14, 15, 16, 17 and 18.
     */
    private static final class V14 {

        private static void install(ClassLoader loader, List<File> additionalClassPathEntries,
                                    File optimizedDirectory) throws IllegalArgumentException,
                IllegalAccessException, NoSuchFieldException, InvocationTargetException,
                NoSuchMethodException {
            /*
             * The patched class loader is expected to be a descendant of
             * dalvik.system.BaseDexClassLoader. We modify its
             * dalvik.system.DexPathList pathList field to append additional DEX
             * file entries.
             */
            Field pathListField = findField(loader, "pathList");
            Object dexPathList = pathListField.get(loader);
            expandFieldArray(dexPathList, "dexElements", makeDexElements(dexPathList,
                    new ArrayList<>(additionalClassPathEntries), optimizedDirectory));
        }

        /**
         * A wrapper around
         * {@code private static final dalvik.system.DexPathList#makeDexElements}
         * .
         */
        private static Object[] makeDexElements(Object dexPathList, ArrayList<File> files,
                                                File optimizedDirectory)
                throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
            Method makeDexElements = findMethod(dexPathList, "makeDexElements",
                    ArrayList.class, File.class);

            return (Object[]) makeDexElements.invoke(dexPathList, files, optimizedDirectory);
        }
    }

    /**
     * Installer for platform versions 4 to 13.
     */
    private static final class V4 {

        private static void install(ClassLoader loader, List<File> additionalClassPathEntries)
                throws IllegalArgumentException, IllegalAccessException, NoSuchFieldException, IOException {
            /*
             * The patched class loader is expected to be a descendant of
             * dalvik.system.DexClassLoader. We modify its fields mPaths,
             * mFiles, mZips and mDexs to append additional DEX file entries.
             */
            int extraSize = additionalClassPathEntries.size();

            Field pathField = findField(loader, "path");

            StringBuilder path = new StringBuilder((String) pathField.get(loader));
            String[] extraPaths = new String[extraSize];
            File[] extraFiles = new File[extraSize];
            ZipFile[] extraZips = new ZipFile[extraSize];
            DexFile[] extraDexs = new DexFile[extraSize];
            for (ListIterator<File> iterator = additionalClassPathEntries.listIterator(); iterator.hasNext(); ) {
                File additionalEntry = iterator.next();
                String entryPath = additionalEntry.getAbsolutePath();
                path.append(':').append(entryPath);
                int index = iterator.previousIndex();
                extraPaths[index] = entryPath;
                extraFiles[index] = additionalEntry;
                extraZips[index] = new ZipFile(additionalEntry);
                extraDexs[index] = DexFile.loadDex(entryPath, entryPath + ".dex", 0);
            }

            pathField.set(loader, path.toString());
            expandFieldArray(loader, "mPaths", extraPaths);
            expandFieldArray(loader, "mFiles", extraFiles);
            expandFieldArray(loader, "mZips", extraZips);
            expandFieldArray(loader, "mDexs", extraDexs);
        }
    }
}
