package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.app.Application;
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

public abstract class XCHook implements Hook {
    private static final String TAG = "XCHook";
    private Map<Class<?>, XCMethodHook> xcMethodHookCache = new LinkedHashMap<>();

    @Override
    public final void install(Context context) {
        fire(context);
        Log.d(TAG, "====> begin call init()");
        init(context);
        Log.d(TAG, "====> end call init()");
        Log.d(TAG, "====> begin call bindXCMethods()");
        bindXCMethods(context);
        Log.d(TAG, "====> end call bindXCMethods()");
    }

    protected void init(Context context) {
    }

    protected abstract void bindXCMethods(Context context);

    private void fire(Context context) {
        Log.d(TAG, "call fire(): " + context);
        if (context instanceof Application) {
            ((Application) context).registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
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

    protected final void executeHook(String className, String methodName, String paramSig,
                                     String xcMethodHookName) {
        try {
            executeHook(className, methodName, paramSig,
                    ReflectClass.load(xcMethodHookName).getOrigClass());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    protected final void executeHook(String className, String methodName, String paramSig,
                                     XCMethodHook xcMethodHookInstance) {
        if ("<init>".equals(methodName)) {
            Class[] srcArgs = Util.getMethodArgs(paramSig, null);
            Object[] mergedSrcArgs = new Object[srcArgs.length];
            for (int i = 0; i < srcArgs.length; ++i) {
                mergedSrcArgs[i] = srcArgs[i];
            }
            try {
                Class<?> xcMethodHookClass = xcMethodHookInstance.getClass();
                if (!xcMethodHookCache.containsKey(xcMethodHookClass)) {
                    xcMethodHookCache.put(xcMethodHookClass, xcMethodHookInstance);
                }

                DexposedBridge.hookMethod(
                        XposedHelpers.findConstructorExact(ReflectClass.load(className).getOrigClass()),
                        xcMethodHookInstance);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } else if (!findAndHookMethod(className, methodName, paramSig, xcMethodHookInstance)) {
            Log.e(TAG, "Oops!!! Failed to find and hook method.");
        }
    }

    protected final void executeHook(String className, String methodName, String paramSig,
                                     Class<?> xcMethodHookClass) {
        if ("<init>".equals(methodName)) {
            Class[] srcArgs = Util.getMethodArgs(paramSig, null);
            Object[] mergedSrcArgs = new Object[srcArgs.length];
            for (int i = 0; i < srcArgs.length; ++i) {
                mergedSrcArgs[i] = srcArgs[i];
            }
            try {
                ReflectClass sClass = ReflectClass.load(xcMethodHookClass);
                ReflectConstructor ctor = sClass.getConstructor();
                XCMethodHook xcMethodHookInstance = (XCMethodHook) ctor.newInstance();
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

    private boolean findAndHookMethod(String className, String methodName, String paramSig,
                                      XCMethodHook xcMethodHookInstance) {
        Log.i(TAG, "call findAndHookMethod(): className=" + className + ", methodName=" + methodName
                + ", paramSig=" + paramSig + ", xcMethodHookInstance=" + xcMethodHookInstance);
        Class[] srcArgs = Util.getMethodArgs(paramSig, null);
        Object[] mergedSrcArgs = new Object[srcArgs.length + 1];
        for (int i = 0; i < srcArgs.length; ++i) {
            mergedSrcArgs[i] = srcArgs[i];
        }

        try {
            mergedSrcArgs[srcArgs.length] = xcMethodHookInstance;
            Class<?> xcMethodHookClass = xcMethodHookInstance.getClass();
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

    private boolean findAndHookMethod(String className, String methodName, String paramSig,
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
            ReflectConstructor ctor = sClass.getConstructor();
            XCMethodHook xcMethodHookInstance = (XCMethodHook) ctor.newInstance();
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

    private void setActivity(Activity activity) {
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
