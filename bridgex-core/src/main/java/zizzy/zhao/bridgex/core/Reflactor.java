package zizzy.zhao.bridgex.core;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.os.IBinder;
import android.os.IInterface;
import android.text.TextUtils;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Arrays;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.reflect.base.ReflectObjectField;
import zizzy.zhao.bridgex.base.utils.BootstrapClass;
import zizzy.zhao.bridgex.core.delegate.ActivityThreadDelegate;
import zizzy.zhao.bridgex.core.delegate.ApplicationPackageManagerDelegate;
import zizzy.zhao.bridgex.core.delegate.ServiceManagerDelegate;

public class Reflactor {

    private static final String TAG = "Reflactor";
    private static boolean inDeveloperMode = false;

    static {
        Log.i(TAG, "Running on sdk version: " + Build.VERSION.SDK_INT);
        if (!BootstrapClass.exemptAll()) {
            Log.w(TAG, "WTF!!! Failed to exempt bootstrap class.");
        }
    }

    public static void hookPMS(Context context) {
        /**
         * 0 text, 1 hashcode
         */
        int signMode;
        String signatureText = null;
        int signatureHashCode = 0;
        String hookPackageName = null;
        String hookPackageVersionName = null;
        int hookPackageVersionCode = 0;

        InputStream is = null;
        try {
            is = context.getResources().getAssets().open("bridgex_conf.json");
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            JSONObject jsonStr = new JSONObject(new String(buffer));
            inDeveloperMode = jsonStr.optBoolean("debuggable", false);
            JSONObject jo = jsonStr.getJSONObject("signature_blasting");
            signMode = jo.optInt("mode", 0);
            switch (signMode) {
                case 0:
                    signatureText = jo.getString("text");
                    break;
                case 1:
                    signatureHashCode = jo.getInt("hash");
                    break;
                default:
                    throw new IllegalArgumentException("Invalid signature mode: " + signMode);
            }
            hookPackageName = jo.optString("hook_package");
            if (!TextUtils.isEmpty(hookPackageName)) {
                hookPackageVersionName = jo.getString("hook_package_version_name");
                hookPackageVersionCode = jo.getInt("hook_package_versoin_code");
            }
        } catch (Throwable th) {
            Log.e(TAG, "Error to parse bridgex_conf.json with " + th);
            return;
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                }
            }
        }

        try {
            // 获取全局的ActivityThread对象
//            Object currentActivityThread = Reflection.readField(
//                    "android.app.ActivityThread",
//                    "sCurrentActivityThread",
//                    null
//            );
            ReflectObjectField sCurrentActivityThread = ActivityThreadDelegate.sCurrentActivityThread;

            // 获取ActivityThread里面原始的 sPackageManager
//            Object sPackageManager = Reflection.readField(
//                    "android.app.ActivityThread",
//                    "sPackageManager",
//                    currentActivityThread
//            );
            ReflectObjectField sPackageManager = ActivityThreadDelegate.sPackageManager;

            // 准备好代理对象, 用来替换原始的对象
//            Class iPackageManagerInterface = Reflection.forName("android.content.pm.IPackageManager");
            ReflectClass iPackageManager = ReflectClass.load("android.content.pm.IPackageManager");

            Object proxy = Proxy.newProxyInstance(
                    iPackageManager.getOrigClass().getClassLoader(),
                    new Class[]{iPackageManager.getOrigClass()},
                    new HookHandler(
                            sPackageManager.get(sCurrentActivityThread.get()),
                            context.getPackageName(),
                            signMode,
                            signatureText,
                            signatureHashCode,
                            hookPackageName,
                            hookPackageVersionName,
                            hookPackageVersionCode
                    )
            );

            // 1. 替换掉ActivityThread里面的 sPackageManager 字段
//            Reflection.writeField(
//                    "android.app.ActivityThread",
//                    "sPackageManager",
//                    currentActivityThread,
//                    proxy
//            );
            sPackageManager.set(sCurrentActivityThread.get(), proxy);

            // 2. 替换 ApplicationPackageManager 里面的 mPm 对象
            PackageManager pm = context.getPackageManager();
//            Reflection.writeField(
//                    "android.app.ApplicationPackageManager",
//                    "mPM",
//                    pm,
//                    proxy
//            );
            ApplicationPackageManagerDelegate.mPM.set(pm, (IInterface) proxy);
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
//        Class<?> serviceManagerClass = Class.forName("android.os.ServiceManager");
//        Method getServiceMethod = serviceManagerClass.getDeclaredMethod("getService", String.class);
//        getServiceMethod.setAccessible(true);
//        Object iBinder = getServiceMethod.invoke(null, new String[]{"package"});

        IBinder iBinder = ServiceManagerDelegate.getService.invoke("package");
        if (inDeveloperMode) {
            Log.v(TAG, "invoke obj: " + iBinder);
        }

//        Class<?> iPackageManager$Stub$ProxyClass = Class.forName("android.content.pm.IPackageManager$Stub$Proxy");
//        Constructor constructor = iPackageManager$Stub$ProxyClass.getDeclaredConstructor(IBinder.class);
//        constructor.setAccessible(true);
//
//        return constructor.newInstance(new Object[]{iBinder});

        ReflectClass sClass = ReflectClass.load("android.content.pm.IPackageManager$Stub$Proxy");
        ReflectConstructor constructor = (ReflectConstructor<IBinder>) sClass.getConstructor(IBinder.class);
        return constructor.newInstance(iBinder);
    }

    static class HookHandler implements InvocationHandler {
        private static final String TAG = "HookHandler";
        private Object base;
        private String packageName;
        private int signMode;
        private String signText;
        private int signHashcode;
        private String hookPackageName;
        private String hookPackageVersionName;
        private int hookPackageVersionCode;

        /**
         * @param signText hex-encoded string representing the signature
         *                 {@link Signature#toCharsString()}
         *                 Signatures are expected to be a hex-encoded ASCII string.
         */
        HookHandler(Object base, String packageName, int signMode, String signText, int signHashcode,
                    String hookPackageName, String hookPackageVersionName, int hookPackageVersionCode) {
            this.base = base;
            this.packageName = packageName;
            this.signMode = signMode;
            this.signText = signText;
            this.signHashcode = signHashcode;
            this.hookPackageName = hookPackageName;
            this.hookPackageVersionName = hookPackageVersionName;
            this.hookPackageVersionCode = hookPackageVersionCode;

            try {
                if (inDeveloperMode) {
                    Log.d(TAG, "new HookHandler(...):\n" + new JSONObject()
                            .put("packageName", packageName)
                            .put("signMode", signMode)
                            .put("signText", signText)
                            .put("signHashcode", signHashcode)
                            .put("hookPackageName", hookPackageName)
                            .put("hookPackageVersionName", hookPackageVersionName)
                            .put("hookPackageVersionCode", hookPackageVersionCode)
                            .toString(2)
                            + "\n");
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        @SuppressLint("SoonBlockedPrivateApi")
        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            if (inDeveloperMode) {
                Log.v(TAG, "--- [" + method.getName() + "] called with args " + Arrays.toString(args));
            }
            if ("getPackageInfo".equals(method.getName())) {
                PackageInfo info = (PackageInfo) method.invoke(base, args);
                if (info != null) {
                    String packageName = (String) args[0];
                    if ("com.android.webview".equals(packageName)) {
                        return method.invoke(base, args);
                    }

                    int flag = (int) args[1];

                    if (flag == PackageManager.GET_SIGNATURES) {
                        if (inDeveloperMode) {
                            Log.d(TAG, "!!!! Bingooooooooooooooooooooooooooooooooooooooooooooooo");
                        }
                        Signature signature;

                        switch (signMode) {
                            case 0:
                                if (TextUtils.isEmpty(signText)) {
                                    throw new IllegalArgumentException("Oops!!! The signature text is empty.");
                                }
                                signature = new Signature(signText);
                                if (inDeveloperMode) {
                                    Log.d(TAG, "The hooked signature hashcode is " + signature.hashCode());
                                }
                                info.signatures[0] = signature;
                                break;
                            case 1:
                                signature = info.signatures[0];
                                if (inDeveloperMode) {
                                    Log.d(TAG, "The origin signature hashcode is " + signature.hashCode());
                                }
                                Class<?> clazz = signature.getClass();
                                Field mHaveHashCodeF = clazz.getDeclaredField("mHaveHashCode");
                                mHaveHashCodeF.setAccessible(true);
                                mHaveHashCodeF.set(signature, true);
                                mHaveHashCodeF.setAccessible(false);

                                Field mHashCodeF = clazz.getDeclaredField("mHashCode");
                                mHashCodeF.setAccessible(true);
                                mHashCodeF.set(signature, signHashcode);
                                mHashCodeF.setAccessible(false);
                                break;
                            default:
                                throw new IllegalArgumentException("Invalid signature mode: " + signMode);
                        }
                    }

                    if (!TextUtils.isEmpty(hookPackageName)) {
                        info.packageName = hookPackageName;
                        info.versionName = hookPackageVersionName;
                        info.versionCode = hookPackageVersionCode;
                    }

                    return info;
                }
            }
            return method.invoke(base, args);
        }
    }
}
