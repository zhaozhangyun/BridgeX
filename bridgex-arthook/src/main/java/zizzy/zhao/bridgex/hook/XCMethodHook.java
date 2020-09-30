package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.util.Log;

import java.util.Arrays;

import de.robv.android.xposed.XC_MethodHook;

public class XCMethodHook extends XC_MethodHook {
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

    protected Object executeHookedMethod(MethodHookParam param) throws Throwable {
        return null;
    }

    protected void endHookedMethod(MethodHookParam param) throws Throwable {
    }

    @Override
    protected final void beforeHookedMethod(MethodHookParam param) throws Throwable {
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

        try {
            Log.d(TAG, "begin call executeHookedMethod ...");
            Object result = executeHookedMethod(param);
            Log.d(TAG, "end call executeHookedMethod result: \'" + result + "\'");
            if (result != null) {
                param.setResult(result);
            }
        } catch (Throwable th) {
            throw new Exception(th);
        }
    }

    @Override
    protected final void afterHookedMethod(MethodHookParam param) throws Throwable {
        super.afterHookedMethod(param);
        Log.d(TAG, "afterHookedMethod: " + param.thisObject.getClass().getName());
        Log.d(TAG, "afterHookedMethod: args=" + Arrays.toString(param.args));
        try {
            endHookedMethod(param);
        } catch (Throwable th) {
            throw new Exception(th);
        }
    }
}
