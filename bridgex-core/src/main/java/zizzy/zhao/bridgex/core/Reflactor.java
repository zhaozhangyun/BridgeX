package zizzy.zhao.bridgex.core;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.os.IBinder;
import android.text.TextUtils;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Arrays;

public class Reflactor {

    public static void hookPMS(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            HiddenApiUtil.exemptAll();
        }

        try {
            // 获取全局的ActivityThread对象
            Object currentActivityThread = getFieldObject(
                    "android.app.ActivityThread",
                    null,
                    "sCurrentActivityThread");

            // 获取ActivityThread里面原始的 sPackageManager
            Object sPackageManager = getFieldObject(
                    "android.app.ActivityThread",
                    currentActivityThread,
                    "sPackageManager");

            /**
             * signature-hook-mode: 0 text 1 hashcode
             */
            int signMode = getMateDate(context, "bridgex.signature-hook-mode");
            String signText = getMateDate(context, "bridgex.signature-hook-text");
            int signHashCode = getMateDate(context, "bridgex.signature-hook-hashcode");

            // 准备好代理对象, 用来替换原始的对象
            Class<?> iPackageManagerInterface = Class.forName("android.content.pm.IPackageManager");
            Object proxy = Proxy.newProxyInstance(iPackageManagerInterface.getClassLoader(),
                    new Class<?>[]{iPackageManagerInterface},
                    new HookHandler(sPackageManager, context.getPackageName(), signMode, signText, signHashCode));

            // 1. 替换掉ActivityThread里面的 sPackageManager 字段
            setFieldObject(
                    "android.app.ActivityThread",
                    currentActivityThread,
                    "sPackageManager",
                    proxy);

            // 2. 替换 ApplicationPackageManager 里面的 mPm 对象
            PackageManager pm = context.getPackageManager();
            setFieldObject(
                    "android.app.ApplicationPackageManager",
                    pm,
                    "mPM",
                    proxy);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void reversePMS(Context context) {
        try {
            Class<?> activityThreadClass = Class.forName("android.app.ActivityThread");
            Method currentActivityThreadMethod = activityThreadClass.getDeclaredMethod(
                    "currentActivityThread");
            Object currentActivityThread = currentActivityThreadMethod.invoke(null);
            //1. 获取全局的ActivityThread对象

            Field sPackageManagerField = activityThreadClass.getDeclaredField("sPackageManager");
            sPackageManagerField.setAccessible(true);
  
            /*通过置空系统IPM来迫使系统产生新的IPM对象,也是一种方法,但是这种方法也可以被HOOK.
             IPackageManager$Stub.asInterface方法里存在Hook点,故不采用此方法.
               
             sPackageManagerField.set(currentActivityThread, null);
             //2. 将sPackageManager置空,让后面反射获取IPackageManager时系统再产生
             //新的IPackageManager
  
             Method getPackageManagerMethod = 
             activityThreadClass.getDeclaredMethod("getPackageManager");
             getPackageManagerMethod.setAccessible(true);
             Object originalIPackageManager = getPackageManagerMethod.invoke(null);
             //3. 获取到的新的IPackageManager,此IPackageManager没有被Hook
             */

            Object ipm = getIPackageManager();
            sPackageManagerField.set(currentActivityThread, ipm);
            //4. 替换掉ActivityThread里面的被Hook过的 sPackageManager 字段

            PackageManager pm = context.getPackageManager();
            Field mPmField = pm.getClass().getDeclaredField("mPM");
            mPmField.setAccessible(true);
            mPmField.set(pm, ipm);
            //5. 替换ApplicationPackageManager里面的被Hook过的mPM对象
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private static Object getIPackageManager() throws Throwable {
        Class<?> serviceManagerClass = Class.forName("android.os.ServiceManager");
        Method getServiceMethod = serviceManagerClass.getDeclaredMethod("getService", String.class);
        getServiceMethod.setAccessible(true);
        Object iBinder = getServiceMethod.invoke(null, new String[]{"package"});

        Class<?> iPackageManager$Stub$ProxyClass = Class.forName("android.content.pm.IPackageManager$Stub$Proxy");
        Constructor constructor = iPackageManager$Stub$ProxyClass.getDeclaredConstructor(IBinder.class);
        constructor.setAccessible(true);

        return constructor.newInstance(new Object[]{iBinder});
    }

    private static Object createObject(String className, Class[] pareTyples, Object[] pareVaules)
            throws Throwable {
        Class r = Class.forName(className);
        Constructor ctor = r.getDeclaredConstructor(pareTyples);
        ctor.setAccessible(true);
        return ctor.newInstance(pareVaules);
    }

    private static Object invokeInstanceMethod(Object obj, String methodName, Class[] pareTyples,
                                               Object[] pareVaules) throws Throwable {
        //调用一个private方法
        Method method = obj.getClass().getDeclaredMethod(methodName, pareTyples); //在指定类中获取指定的方法
        method.setAccessible(true);
        return method.invoke(obj, pareVaules);
    }

    /**
     * 反射静态方法
     *
     * @param className   类名
     * @param method_name 方法名
     * @param pareTyples  参数类型class
     * @param pareVaules  对应类型的参数值
     * @return
     */
    private static Object invokeStaticMethod(String className, String method_name,
                                             Class[] pareTyples, Object[] pareVaules)
            throws Throwable {
        Class obj_class = Class.forName(className);
        Method method = obj_class.getDeclaredMethod(method_name, pareTyples);
        method.setAccessible(true);
        return method.invoke(null, pareVaules);
    }

    /**
     * 反射属性
     *
     * @param className
     * @param obj
     * @param filedName
     * @return
     */
    private static Object getFieldObject(String className, Object obj, String filedName)
            throws Throwable {
        Class obj_class = Class.forName(className);
        Field field = obj_class.getDeclaredField(filedName);
        field.setAccessible(true);
        return field.get(obj);
    }

    private static void setFieldObject(String classname, Object obj, String filedName,
                                       Object filedVaule) throws Throwable {
        Class obj_class = Class.forName(classname);
        Field field = obj_class.getDeclaredField(filedName);
        field.setAccessible(true);
        field.set(obj, filedVaule);
    }

    static class HookHandler implements InvocationHandler {
        private static final String TAG = "HookHandler";
        private Object base;
        private String packageName;
        private int signMode;
        private String signText;
        private int signHashcode;

        /**
         * @param signText hex-encoded string representing the signature
         *                 {@link Signature#toCharsString()}
         *                 Signatures are expected to be a hex-encoded ASCII string.
         */
        HookHandler(Object base, String packageName, int signMode, String signText, int signHashcode) {
            this.base = base;
            this.packageName = packageName;
            this.signMode = signMode;
            this.signText = signText;
            this.signHashcode = signHashcode;
            Log.i(TAG, "HookHandler<init>: packageName=" + packageName + ", signMode=" + signMode
                    + ", signText=" + signText + ", signHashcode=" + signHashcode);
        }

        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            Log.v(TAG, "--- [" + method.getName() + "] called with args " + Arrays.toString(args));
            if ("getPackageInfo".equals(method.getName())) {
                String pkg = (String) args[0];
                int flag = (int) args[1];

                PackageInfo info = (PackageInfo) method.invoke(base, args);
                if (info != null) {
                    if (pkg.equals(packageName) && flag == PackageManager.GET_SIGNATURES) {
                        Log.i(TAG, "!!!! Bingooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
                        Signature signature;

                        switch (signMode) {
                            case 0:
                                if (TextUtils.isEmpty(signText)) {
                                    throw new IllegalArgumentException("Oops!!! The signature text is empty.");
                                }
                                signature = new Signature(signText);
                                Log.i(TAG, "The hooked signature hashcode is " + signature.hashCode());
                                info.signatures[0] = signature;
                                break;
                            case 1:
                                signature = info.signatures[0];
                                Log.i(TAG, "The origin signature hashcode is " + signature.hashCode());
                                Class<?> clazz = signature.getClass();
                                Field mHaveHashCodeF = clazz.getDeclaredField("mHaveHashCode");
                                mHaveHashCodeF.setAccessible(true);
                                mHaveHashCodeF.set(signature, true);

                                Field mHashCodeF = clazz.getDeclaredField("mHashCode");
                                mHashCodeF.setAccessible(true);
                                mHashCodeF.set(signature, signHashcode);
                                break;
                            default:
                                throw new IllegalArgumentException("Invalid signature mode: " + signMode);
                        }
                    }
                    return info;
                }
            }
            return method.invoke(base, args);
        }
    }

    private static <T> T getMateDate(Context context, String metadata) {
        T result;

        try {
            ApplicationInfo applicationInfo = context.getPackageManager().getApplicationInfo(
                    context.getPackageName(), PackageManager.GET_META_DATA);
            if (applicationInfo == null
                    || !applicationInfo.metaData.containsKey(metadata)
                    || (result = (T) applicationInfo.metaData.get(metadata)) == null) {
                return null;
            }
            return result;
        } catch (Throwable th) {
            th.printStackTrace();
        }

        return null;
    }

    static class HiddenApiUtil {
        private static Method sSetHiddenApiExemptions;
        private static Object sVMRuntime;

        static {
            try {
                Method forNameMethod = Class.class.getDeclaredMethod("forName", String.class);
                Method getDeclaredMethodMethod = Class.class.getDeclaredMethod(
                        "getDeclaredMethod", String.class, Class[].class);

                Class vmRuntimeClass = (Class) forNameMethod.invoke(null, "dalvik.system.VMRuntime");
                sSetHiddenApiExemptions = (Method) getDeclaredMethodMethod.invoke(vmRuntimeClass,
                        "setHiddenApiExemptions", new Class[]{String[].class});
                Method getVMRuntimeMethod = (Method) getDeclaredMethodMethod.invoke(vmRuntimeClass,
                        "getRuntime", null);
                sVMRuntime = getVMRuntimeMethod.invoke(null);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }

        static boolean setExemptions(String... methods) {
            if ((sSetHiddenApiExemptions == null)
                    || (sVMRuntime == null)) {
                return false;
            }

            try {
                sSetHiddenApiExemptions.invoke(sVMRuntime, new Object[]{methods});
                return true;
            } catch (Throwable e) {
                return false;
            }
        }

        static boolean exemptAll() {
            return setExemptions("L");
        }
    }
}
