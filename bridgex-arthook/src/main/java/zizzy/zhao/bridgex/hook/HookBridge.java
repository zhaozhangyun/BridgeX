package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import de.robv.android.xposed.DexposedBridge;
import de.robv.android.xposed.XposedHelpers;
import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.utils.Util;

public class HookBridge {
    private static final String TAG = "HookBridge";
    private static Context sContext;
    private static Map<Class<?>, XCMethodHook> xcMethodHookCache = new LinkedHashMap<>();

    public static void fire(Context context) {
        Log.d(TAG, "call fire(): " + context);
        sContext = context.getApplicationContext();
        if (context instanceof Application) {
            ((Application) context).registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
                @Override
                public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                    Log.v(TAG, String.format("====> [%s] created", activity.getLocalClassName()));
                    setActivity(activity);
                }

                @Override
                public void onActivityStarted(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] started", activity.getLocalClassName()));
                }

                @Override
                public void onActivityResumed(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] resumed", activity.getLocalClassName()));
                    setActivity(activity);
                }

                @Override
                public void onActivityPaused(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] paused", activity.getLocalClassName()));
                }

                @Override
                public void onActivityStopped(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] stopped", activity.getLocalClassName()));
                }

                @Override
                public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
                    Log.v(TAG, String.format("====> [%s] save instance state", activity.getLocalClassName()));
                }

                @Override
                public void onActivityDestroyed(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] destroyed", activity.getLocalClassName()));
                }
            });
        } else {
            throw new IllegalStateException("Oops!!! The context must be Application.");
        }
    }

    public static void executeHook(String className,
                                   String methodName,
                                   String paramSig,
                                   String xcMethodHookName) {
        try {
            executeHook(className, methodName, paramSig,
                    ReflectClass.load(xcMethodHookName).getOrigClass());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void executeHook(String className,
                                   String methodName,
                                   String paramSig,
                                   Class<?> xcMethodHookClass) {
        if ("<init>".equals(methodName)) {
            Class[] srcArgs = Util.getMethodArgs(paramSig, null);
            Object[] mergedSrcArgs = new Object[srcArgs.length];
            for (int i = 0; i < srcArgs.length; ++i) {
                mergedSrcArgs[i] = srcArgs[i];
            }
            try {
                ReflectClass sClass = ReflectClass.load(xcMethodHookClass);
                ReflectConstructor ctor = sClass.getConstructor(Class[].class);
                XCMethodHook xcMethodHookInstance = (XCMethodHook) ctor.newInstance((Object) srcArgs);
                xcMethodHookInstance.install(sContext);
                if (!xcMethodHookCache.containsKey(xcMethodHookClass)) {
                    xcMethodHookCache.put(xcMethodHookClass, xcMethodHookInstance);
                }

                DexposedBridge.hookMethod(
                        XposedHelpers.findConstructorExact(ReflectClass.load(className).getOrigClass()),
                        xcMethodHookInstance);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } else if (!findAndHookMethod(className, methodName, paramSig, xcMethodHookClass)) {
            Log.e(TAG, "Oops!!! Failed to find and hook method.");
        }
    }

    private static boolean findAndHookMethod(String className,
                                             String methodName,
                                             String paramSig,
                                             Class<?> xcMethodHookClass) {
        Log.i(TAG, "call findAndHookMethod(): className=" + className + ", methodName=" + methodName
                + ", paramSig=" + paramSig + ", xcMethodHookClass=" + xcMethodHookClass);
        Class[] srcArgs = Util.getMethodArgs(paramSig, null);
        Object[] mergedSrcArgs = new Object[srcArgs.length + 1];
        for (int i = 0; i < srcArgs.length; ++i) {
            mergedSrcArgs[i] = srcArgs[i];
        }

        try {
            ReflectClass sClass = ReflectClass.load(xcMethodHookClass);
            ReflectConstructor ctor = sClass.getConstructor(Class[].class);
            XCMethodHook xcMethodHookInstance = (XCMethodHook) ctor.newInstance((Object) srcArgs);
            xcMethodHookInstance.install(sContext);
            mergedSrcArgs[srcArgs.length] = xcMethodHookInstance;
            if (!xcMethodHookCache.containsKey(xcMethodHookClass)) {
                xcMethodHookCache.put(xcMethodHookClass, xcMethodHookInstance);
            }

            DexposedBridge.findAndHookMethod(
                    ReflectClass.load(className).getOrigClass(),
                    methodName,
                    mergedSrcArgs);
        } catch (Throwable th) {
            th.printStackTrace();
        }

        return true;
    }

    private static void setActivity(Activity activity) {
        Iterator<Map.Entry<Class<?>, XCMethodHook>> iterator = xcMethodHookCache.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<Class<?>, XCMethodHook> entry = iterator.next();
            try {
                entry.getValue().setActivity(activity);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }
}