package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import de.robv.android.xposed.DexposedBridge;
import de.robv.android.xposed.XposedHelpers;
import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.utils.Util;

public class HookBridge {
    private static final String TAG = "HookBridge";
    private static Activity sActivity;

    public static void fire(Context context) {
        Log.d(TAG, "call fire(): " + context);
        if (context instanceof Application) {
            ((Application) context).registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
                @Override
                public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                    Log.v(TAG, String.format("====> [%s] created", activity.getLocalClassName()));
                    sActivity = activity;
                }

                @Override
                public void onActivityStarted(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] started", activity.getLocalClassName()));
                }

                @Override
                public void onActivityResumed(Activity activity) {
                    Log.v(TAG, String.format("====> [%s] resumed", activity.getLocalClassName()));
                    sActivity = activity;
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

    public static <T extends XCMethodHook> void executeHook(String className,
                                                            String methodName,
                                                            String paramSig,
                                                            String xcMethodHookName) throws Throwable {
        executeHook(className, methodName, paramSig, ReflectClass.load(xcMethodHookName).getOrigClass());
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
                xcMethodHookInstance.setActivity(sActivity);

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
            mergedSrcArgs[srcArgs.length] = xcMethodHookInstance;
            xcMethodHookInstance.setActivity(sActivity);

            DexposedBridge.findAndHookMethod(
                    ReflectClass.load(className).getOrigClass(),
                    methodName,
                    mergedSrcArgs);
        } catch (Throwable th) {
            th.printStackTrace();
        }

        return true;
    }
}
