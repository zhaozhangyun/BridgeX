package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.util.Log;

import java.util.Arrays;

import de.robv.android.xposed.XC_MethodHook;

public abstract class XCMethodHook extends XC_MethodHook {
    private static final String TAG = "XC_MethodHook_Impl";
    public static final int INVALID = -1;
    private Activity activity;
    private int callbackIndex = INVALID;
    private Class[] srcArgs;

    public XCMethodHook(Class[] srcArgs) {
        this.srcArgs = srcArgs;
    }

    public final void setActivity(Activity activity) {
        this.activity = activity;
    }

    protected final Activity getActivity() {
        return activity;
    }

    protected abstract Object executeHookedMethod(MethodHookParam param);

    protected abstract void endHookedMethod(MethodHookParam param);

    @Override
    protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
        super.beforeHookedMethod(param);
        Log.d(TAG, "beforeHookedMethod: thisObject=" + param.thisObject.getClass().getName());
        Log.d(TAG, "beforeHookedMethod: method=" + param.method);
        Log.d(TAG, "beforeHookedMethod: args=" + Arrays.toString(param.args));

        for (int i = 0; i < srcArgs.length; ++i) {
            Class interfaceClass = srcArgs[i];
            if (interfaceClass.isInterface()) {
                callbackIndex = i;
                Log.d(TAG, "The interface [" + interfaceClass + "] index is " + callbackIndex);
                break;
            }
        }

        Object result = executeHookedMethod(param);
        param.setResult(result);
    }

    @Override
    protected void afterHookedMethod(MethodHookParam param) throws Throwable {
        super.afterHookedMethod(param);
        Log.d(TAG, "afterHookedMethod: " + param.thisObject.getClass().getName());
        Log.d(TAG, "afterHookedMethod: args=" + Arrays.toString(param.args));
        endHookedMethod(param);
    }
}
