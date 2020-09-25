package zizzy.zhao.bridgex.hook;

import android.util.Log;

import de.robv.android.xposed.DexposedBridge;
import zizzy.zhao.bridgex.core.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.core.utils.Util;
import zizzy.zhao.bridgex.hook.mltad.MltAdMethodHook;

public class HookBridge {
    private static final String TAG = "HookBridge";

    private static class Holder {
        private volatile static HookBridge instance = new HookBridge();
    }

    public static HookBridge getInstance() {
        return Holder.instance;
    }

    public void executeHook(String className, String methodName, String paramSig) {
        if (!findAndHookMethod(className, methodName, paramSig)) {
            Log.e(TAG, "Oops!!! Failed to find and hook method.");
        }
    }

    private boolean findAndHookMethod(String className, String methodName, String paramSig) {
        Class[] srcArgs = Util.getMethodArgs(paramSig, null);

        try {
            Object[] mergedSrcArgs = new Object[srcArgs.length + 1];
            for (int i = 0; i < srcArgs.length; ++i) {
                mergedSrcArgs[i] = srcArgs[i];
            }
            mergedSrcArgs[srcArgs.length] = new MltAdMethodHook(srcArgs);

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
