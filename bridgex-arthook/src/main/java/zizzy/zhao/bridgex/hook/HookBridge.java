package zizzy.zhao.bridgex.hook;

import android.util.Log;

import de.robv.android.xposed.DexposedBridge;
import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.utils.Util;

public class HookBridge<T extends XCMethodHook> {
    private static final String TAG = "HookBridge";

    private static class Holder {
        private volatile static HookBridge instance = new HookBridge();
    }

    public static HookBridge getInstance() {
        return Holder.instance;
    }

    public void executeHook(String className, String methodName, String paramSig,
                            Class<T> methodHookClass) {
        if (!findAndHookMethod(className, methodName, paramSig, methodHookClass)) {
            Log.e(TAG, "Oops!!! Failed to find and hook method.");
        }
    }

    private boolean findAndHookMethod(String className, String methodName, String paramSig,
                                      Class<T> methodHookClass) {
        Class[] srcArgs = Util.getMethodArgs(paramSig, null);

        try {
            Object[] mergedSrcArgs = new Object[srcArgs.length + 1];
            for (int i = 0; i < srcArgs.length; ++i) {
                mergedSrcArgs[i] = srcArgs[i];
            }

            ReflectClass sClass = ReflectClass.load(methodHookClass);
            ReflectConstructor constructor = (ReflectConstructor<T>) sClass.getConstructor(Class[].class);
            Object instance = constructor.newInstance(srcArgs);
            mergedSrcArgs[srcArgs.length] = instance;

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
