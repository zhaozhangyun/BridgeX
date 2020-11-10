package zizzy.zhao.bridgex.core;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.DeadSystemException;
import android.text.TextUtils;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.lang.ref.WeakReference;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import zizzy.zhao.bridgex.base.utils.Md5Util;

public class LogBridge {

    private static final String TAG = "logbridge";
    private static LogBridge instance;
    private static Object lock = new Object[0];

    private AtomicInteger atomI;
    private String defaultTag;
    private boolean enabled;
    private boolean debuggable;
    private int maxLogStackIndex;
    private boolean showAllStack;
    private boolean enableStackPackage;
    private int startIndex;
    private String stackPackage;
    private boolean exportJson;
    private File exportJsonDir;
    private Map<String, String> fileCache;

    public static void init(Context context) {
        Context ctx = context.getApplicationContext();
        if (instance == null) {
            synchronized (lock) {
                if (instance == null) {
                    InputStream is = null;
                    try {
                        is = ctx.getResources().getAssets().open("logbridge_conf.json");
                        int size = is.available();
                        byte[] buffer = new byte[size];
                        is.read(buffer);
                        JSONObject jo = new JSONObject(new String(buffer));
                        instance = new LogBridge.Builder(ctx)
                                .defaultTag(jo.optString("default_tag"))
                                .enabled(jo.optBoolean("enabled"))
                                .debuggable(jo.optBoolean("debuggable"))
                                .externalDir(new File(jo.optString("external_dir",
                                        "logbridge")).getName())
                                .showAllStack(jo.optBoolean("show_all_stack"))
                                .maxLogStackIndex(jo.optInt("max_stack_index"))
                                .enableStackPackage(jo.optJSONObject("stack_package")
                                        .optBoolean("enabled"))
                                .startIndex(jo.optJSONObject("stack_package")
                                        .optInt("start_index"))
                                .stackPackage(jo.optJSONObject("stack_package")
                                        .optString("package"))
                                .exportJson(jo.optBoolean("export_json"))
                                .build();
                    } catch (Throwable th) {
                        Log.e(TAG, "Error to parse bridgex_conf.json with " + th);
                        instance = new LogBridge.Builder(ctx).build();
                    } finally {
                        if (is != null) {
                            try {
                                is.close();
                            } catch (IOException e) {
                            }
                        }
                    }
                }
            }
        }
    }

    private LogBridge(Builder builder) {
        defaultTag = builder.tag;
        enabled = builder.enabled;
        debuggable = builder.debuggable;
        showAllStack = builder.showAllStack;
        maxLogStackIndex = builder.maxLogStackIndex;
        enableStackPackage = builder.enableStackPackage;
        startIndex = builder.startIndex;
        stackPackage = builder.stackPackage;
        exportJson = builder.exportJson;
        exportJsonDir = builder.exportJsonDir;

        if (!enabled) {
            Log.w(defaultTag, "Oooooooooooooooooooooooooooooooops! LogBridge is not enabled.");
            debuggable = false;
        }

        atomI = new AtomicInteger(0);
        fileCache = new LinkedHashMap<>();
    }

    public static void log(int source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(String.valueOf(source));
    }

    public static void log(long source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(String.valueOf(source));
    }

    public static void log(float source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(String.valueOf(source));
    }

    public static void log(double source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(String.valueOf(source));
    }

    public static void log(boolean source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(Boolean.valueOf(source));
    }

    public static void log() {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();
        log(new Object[]{});
    }

    public static void log(Object source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();

        List<Object> list = new ArrayList<>();
        list.add(source);
        log(list.toArray());
    }

    public static void log(Object... args) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();

        if (args == null || args.length == 0) {
            log(null, null);
            return;
        }

        StringBuilder builder = new StringBuilder();
        boolean isFirst = true;
        for (Object arg : args) {
            // check json
            WeakReference wr = null;
            try {
                wr = new WeakReference<>(new JSONObject(arg.toString()));
            } catch (Throwable th1) {
                try {
                    wr = new WeakReference<>(new JSONArray(arg.toString()));
                } catch (Throwable th2) {
                }
            }

            if (wr != null) {
                arg = instance.formatJson(instance.format(arg));
                if (instance.exportJson) {
                    String jsonFilePath = instance.exportJson(arg);
                    if (!TextUtils.isEmpty(jsonFilePath)) {
                        builder.append("\n++++++>>>>>> ").append(jsonFilePath);
                    }
                }
            } else if (arg instanceof Bundle) { // check bundle
                arg = instance.formatBundle((Bundle) arg);
            }

            if (isFirst) {
                isFirst = false;
                builder.append(arg);
            } else {
                builder.append(", " + arg);
            }
        }

        log(null, builder.toString());
    }

    public static void logFormat(String format, Object... args) {
        log(String.format(Locale.US, format, args));
    }

    public static void log(String tag, Object source) {
        if (instance == null) {
            throw new NullPointerException("The Logger instance is null!");
        }

        instance.atomI.incrementAndGet();

        StringBuilder builder = new StringBuilder();

        // check json
        WeakReference wr = null;
        try {
            wr = new WeakReference<>(new JSONObject(source.toString()));
        } catch (Throwable th1) {
            try {
                wr = new WeakReference<>(new JSONArray(source.toString()));
            } catch (Throwable th2) {
            }
        }

        if (wr != null) {
            source = instance.format(instance.formatJson(source));
            if (instance.exportJson) {
                String jsonFilePath = instance.exportJson(source);
                if (!TextUtils.isEmpty(jsonFilePath)) {
                    builder.append("\n++++++>>>>>> ").append(jsonFilePath);
                }
            }
        } else if (source instanceof Bundle) { // check bundle
            source = instance.formatBundle((Bundle) source);
        }
        builder.append(source);

        instance.log(tag, Log.DEBUG, builder.toString(), null);
    }

    private static boolean ensureCreated(File folder) {
        if (!folder.exists() && !folder.mkdirs()) {
            Log.w(TAG, "Unable to create the directory: " + folder.getPath());
            return false;
        } else {
            return true;
        }
    }

    private String formatBundle(Bundle bundle) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n").append(getSplitter(87));
        for (String key : bundle.keySet()) {
            sb.append(formatString("\n| %-40s | %-40s |", key, bundle.get(key)));
            sb.append("\n").append(getSplitter(87));
        }
        return sb.toString();
    }

    private String formatString(String format, Object... args) {
        return String.format(Locale.US, format, args);
    }

    private void log(String tag, int priority, Object source, Throwable th) {
        if (!enabled && !Log.isLoggable(defaultTag, priority)) {
            return;
        }

        if (!TextUtils.isEmpty(tag) && !defaultTag.equalsIgnoreCase(tag)) {
            tag = defaultTag + "-" + tag;
        } else {
            tag = defaultTag;
        }

        if (source != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && debuggable) {
                Log.v(defaultTag, "source type: " + source.getClass().getTypeName());
            }
        }

        Throwable throwable = new Throwable();
        if (debuggable) {
            Log.v(defaultTag + " ++++++", getFormatLog(source), throwable);
        }

        int currentIndex = atomI.incrementAndGet() + startIndex;
        if (debuggable) {
            Log.v(defaultTag, "atomI: " + atomI.get());
            Log.v(defaultTag, "currentIndex: " + currentIndex);
        }

        String fileName;
        String className;
        String methodClass;
        int lineNumber;
        String space = " ";

        StackTraceElement[] stacks = throwable.fillInStackTrace().getStackTrace();
        int stackSize = maxLogStackIndex + currentIndex + 1;
        int maxStackSize = stackSize <= stacks.length ? stackSize : stacks.length;
        if (debuggable) {
            Log.v(defaultTag, "stackSize: " + stacks.length);
            Log.v(defaultTag, "maxStackSize: " + maxStackSize);
        }

        StringBuilder stackBuilder = new StringBuilder();
        boolean isFirstLine = true;
        List<String> stackList = new ArrayList<>();
        StringBuilder diffBuilder = null;

        for (int i = currentIndex; i < maxStackSize; i++) {
            StackTraceElement element = stacks[i];
            fileName = element.getFileName();
            className = element.getClassName();
            methodClass = element.getMethodName();
            lineNumber = element.getLineNumber();

            if (TextUtils.isEmpty(fileName)) {
                fileName = "Unknown Source";
                lineNumber = 0;
            }

            if (lineNumber == -2) {
                fileName = "Native Method";
            }

            if (isFirstLine) {
                isFirstLine = false;

                if (lineNumber != -2) {
                    stackBuilder.append(String.format("--- [%s:%s] %s.%s %s", fileName, lineNumber, className,
                            methodClass, getFormatLog(source)));
                } else {
                    stackBuilder.append(String.format("--- [%s] %s.%s %s", fileName, className,
                            methodClass, getFormatLog(source)));
                }
            } else if (showAllStack && i > currentIndex) {
                if (enableStackPackage) {
                    int diffValue = diff(className, stackPackage);
                    if (diffBuilder == null) {
                        diffBuilder = new StringBuilder();
                    }
                    diffBuilder.append("" + diffValue);
                }

                if (lineNumber != -2) {
                    stackList.add(String.format("%s|-- [%s:%s] %s.%s", space,
                            fileName, lineNumber, className, methodClass));
                } else {
                    stackList.add(String.format("%s|-- [%s] %s.%s", space,
                            fileName, className, methodClass));
                }
                space += "  ";
            }
        }

        if (showAllStack) {
            int stackLen = stackList.size();

            if (enableStackPackage) {
                String diffSeq = null;
                if (diffBuilder != null) {
                    diffSeq = diffBuilder.toString();
                }
                stackLen = getRealStackLen(diffSeq, stackList);
            }

            for (int i = 0; i < stackLen; i++) {
                stackBuilder.append("\n").append(stackList.get(i));
            }
        }

        int len = printlns(priority, tag, stackBuilder.toString(), th);
        if (debuggable) {
            Log.v(defaultTag, "printLength: " + len);
        }

        atomI.getAndSet(0);
    }

    private String exportJson(Object source) {
        if (TextUtils.isEmpty(source.toString())) {
            return null;
        }

        String md5 = Md5Util.getMd5(source.toString());
        if (fileCache != null && fileCache.containsKey(md5)) {
            return fileCache.get(md5);
        }

        String jsonFileName = md5 + ".json";
        File file = new File(exportJsonDir, jsonFileName);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (Throwable th) {
            }
        }

        BufferedWriter bufWriter = null;
        try {
            bufWriter = new BufferedWriter(new FileWriter(file, true));
            bufWriter.write(source.toString());
            bufWriter.newLine();
            bufWriter.flush();
        } catch (Throwable th) {
            return null;
        } finally {
            if (bufWriter != null) {
                try {
                    bufWriter.close();
                } catch (IOException e) {
                }
            }
        }

        if (fileCache != null && !fileCache.containsKey(md5)) {
            fileCache.put(md5, file.getAbsolutePath());
        }

        return file.getAbsolutePath();
    }

    private int getRealStackLen(String diffSeq, List<String> stackList) {
        if (debuggable) {
            Log.v(defaultTag, "diffBuilder=" + diffSeq);
        }

        if (!TextUtils.isEmpty(diffSeq) && diffSeq.length() != stackList.size()) {
            return 0;
        }

        int stackLen = 0;

        if (!TextUtils.isEmpty(diffSeq) && diffSeq.startsWith("1")) {
            int lastIndex = diffSeq.lastIndexOf("1");
            if (debuggable) {
                Log.v(defaultTag, "lastIndex=" + lastIndex);
            }
            stackLen = lastIndex + 1;
        }

        if (debuggable) {
            Log.v(defaultTag, "stackLen=" + stackLen);
        }

        return stackLen;
    }

    private int diff(String clazz, String stackPackage) {
        if (debuggable) {
            Log.v(defaultTag, "call diff(): clazz=" + clazz + ", stackPackage=" + stackPackage);
        }
        if (TextUtils.isEmpty(clazz)) {
            return 0;
        }

        if (clazz.equals(stackPackage)) {
            return 1;
        }

        try {
            String[] split1 = clazz.split("\\.");
            String[] split2 = stackPackage.split("\\.");
            int len = Math.min(split1.length, split2.length);
            int n = 0;
            int i = 0;
            do {
                String s1 = split1[i];
                String s2 = split2[i];
                if (s1.equals(s2)) {
                    n++;
                }
            } while (++i < len);

            if (n == len) {
                return 1;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }

        return 0;
    }

    private String getFormatLog(Object o) {
        return o == null ? String.format("---> <CALL>") : String.format("---> %s", o);
    }

    private String formatJson(Object source) {
        Object o = getJsonObjFromStr(source);
        if (o != null) {
            try {
                if (o instanceof JSONObject) {
                    return ((JSONObject) o).toString(2);
                } else if (o instanceof JSONArray) {
                    return ((JSONArray) o).toString(2);
                } else {
                    return source.toString();
                }
            } catch (JSONException e) {
                return source.toString();
            }
        } else {
            return source.toString();
        }
    }

    private String getSplitter(int length) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < length; i++) {
            builder.append("-");
        }
        return builder.toString();
    }

    private String format(Object source) {
        StringBuilder builder = new StringBuilder();
        builder.append("\n");
        builder.append(getSplitter(100));
        builder.append("\n");
        builder.append(source);
        builder.append("\n");
        builder.append(getSplitter(100));
        return builder.toString();
    }

    private Object getJsonObjFromStr(Object test) {
        Object o = null;
        try {
            o = new JSONObject(test.toString());
        } catch (JSONException ex) {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    o = new JSONArray(test);
                }
            } catch (JSONException ex1) {
                return null;
            }
        }
        return o;
    }

    private int printlns(int priority, String tag, String msg, Throwable tr) {
        ImmediateLogWriter logWriter = new ImmediateLogWriter(priority, tag);
        // Acceptable buffer size. Get the native buffer size, subtract two zero terminators,
        // and the length of the tag.
        // Note: we implicitly accept possible truncation for Modified-UTF8 differences. It
        //       is too expensive to compute that ahead of time.
        int bufferSize = PreloadHolder.LOGGER_ENTRY_MAX_PAYLOAD    // Base.
                - 2                                                // Two terminators.
                - (tag != null ? tag.length() : 0)                 // Tag length.
                - 32;                                              // Some slack.
        // At least assume you can print *some* characters (tag is not too large).
        bufferSize = Math.max(bufferSize, 100);

        LineBreakBufferedWriter lbbw = new LineBreakBufferedWriter(logWriter, bufferSize);

        lbbw.println(msg);

        if (tr != null) {
            // This is to reduce the amount of log spew that apps do in the non-error
            // condition of the network being unavailable.
            Throwable t = tr;
            while (t != null) {
                if (t instanceof UnknownHostException) {
                    break;
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    if (t instanceof DeadSystemException) {
                        lbbw.println("DeadSystemException: The system died; "
                                + "earlier logs will point to the root cause");
                        break;
                    }
                }
                t = t.getCause();
            }
            if (t == null) {
                tr.printStackTrace(lbbw);
            }
        }

        lbbw.flush();

        return logWriter.getWritten();
    }

    /**
     * PreloadHelper class. Caches the LOGGER_ENTRY_MAX_PAYLOAD value to avoid
     * a JNI call during logging.
     */
    static class PreloadHolder {
        public final static int LOGGER_ENTRY_MAX_PAYLOAD = 4000;
    }

    private static class Builder {

        private static final String EXT_DIR_NAME = "logbridge";
        private Context context;
        private String tag;
        private boolean enabled;
        private boolean debuggable;
        private boolean showAllStack;
        private int maxLogStackIndex;
        private boolean enableStackPackage;
        private int startIndex;
        private String stackPackage;
        private boolean exportJson;
        private File exportJsonDir;
        private File externalDir;

        private Builder(Context context) {
            this.context = context.getApplicationContext();
            this.tag = TAG;
            maxLogStackIndex = 16;
        }

        private Builder enabled(boolean enabled) {
            this.enabled = enabled;
            return this;
        }

        private Builder debuggable(boolean debuggable) {
            this.debuggable = debuggable;
            return this;
        }

        private Builder defaultTag(String tag) {
            this.tag = tag;
            return this;
        }

        private Builder showAllStack(boolean showAllStack) {
            this.showAllStack = showAllStack;
            return this;
        }

        private Builder maxLogStackIndex(int maxLogStackIndex) {
            this.maxLogStackIndex = maxLogStackIndex;
            return this;
        }

        private Builder enableStackPackage(boolean enableStackPackage) {
            this.enableStackPackage = enableStackPackage;
            return this;
        }

        private Builder startIndex(int index) {
            if (index < 0) {
                index = 0;
            }
            this.startIndex = index;
            return this;
        }

        private Builder stackPackage(String stackPackage) {
            if (TextUtils.isEmpty(stackPackage)) {
                stackPackage = context.getPackageName();
            }
            this.stackPackage = stackPackage;
            return this;
        }

        private Builder exportJson(boolean exportJson) {
//            int permission1 = ContextCompat.checkSelfPermission(context.getApplicationContext(),
//                    Manifest.permission.WRITE_EXTERNAL_STORAGE);
//            int permission2 = ContextCompat.checkSelfPermission(context.getApplicationContext(),
//                    Manifest.permission.READ_EXTERNAL_STORAGE);
//            if (permission1 != PackageManager.PERMISSION_GRANTED ||
//                    permission2 != PackageManager.PERMISSION_GRANTED) {
//                return this;
//            }

            if (externalDir == null || !externalDir.exists()) {
                return this;
            }

            this.exportJson = exportJson;

            File jsonDir = new File(externalDir, "json");
            ensureCreated(jsonDir);
            this.exportJsonDir = new File(jsonDir, Md5Util.getMd5(String.valueOf(System.currentTimeMillis())));
            ensureCreated(exportJsonDir);
            Log.i(tag, "==========> export json folder path: " + exportJsonDir.getAbsolutePath());
            return this;
        }

        private Builder externalDir(String dir) {
            if (TextUtils.isEmpty(dir)) {
                dir = EXT_DIR_NAME;
            }
//            int permission1 = ContextCompat.checkSelfPermission(context.getApplicationContext(),
//                    Manifest.permission.WRITE_EXTERNAL_STORAGE);
//            int permission2 = ContextCompat.checkSelfPermission(context.getApplicationContext(),
//                    Manifest.permission.READ_EXTERNAL_STORAGE);
//            if (permission1 != PackageManager.PERMISSION_GRANTED ||
//                    permission2 != PackageManager.PERMISSION_GRANTED) {
//                return this;
//            }
            try {
                this.externalDir = this.context.getExternalFilesDir(dir);
                ensureCreated(externalDir);
            } catch (Throwable th) {
                th.printStackTrace();
            }
            return this;
        }

        private LogBridge build() {
            return new LogBridge(this);
        }
    }

    /**
     * Helper class to write to the logcat. Different from LogWriter, this writes
     * the whole given buffer and does not break along newlines.
     */
    static class ImmediateLogWriter extends Writer {

        private int priority;
        private String tag;

        private int written = 0;

        /**
         * Create a writer that immediately writes to the log, using the given
         * parameters.
         */
        ImmediateLogWriter(int priority, String tag) {
            this.priority = priority;
            this.tag = tag;
        }

        int getWritten() {
            return written;
        }

        @Override
        public void write(char[] cbuf, int off, int len) {
            // Note: using String here has a bit of overhead as a Java object is created,
            //       but using the char[] directly is not easier, as it needs to be translated
            //       to a C char[] for logging.
            written += Log.println(priority, tag, new String(cbuf, off, len));
        }

        @Override
        public void flush() {
            // Ignored.
        }

        @Override
        public void close() {
            // Ignored.
        }
    }
}
