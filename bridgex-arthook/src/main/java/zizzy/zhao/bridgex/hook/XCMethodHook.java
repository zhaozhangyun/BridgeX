package zizzy.zhao.bridgex.hook;

import android.app.Activity;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.Executable;
import java.lang.reflect.Method;
import java.util.Arrays;

import de.robv.android.xposed.XC_MethodHook;

public abstract class XCMethodHook extends XC_MethodHook {
    private static final String TAG = "XCMethodHook";
    public static final int INVALID = -1;
    private Activity activity;
    private int callbackIndex = INVALID;

    protected XCMethodHook() {
    }

    public final void setActivity(Activity activity) {
        this.activity = activity;
    }

    protected final Activity getActivity() {
        return activity;
    }

    protected abstract Object executeHookedMethod(MethodHookParam param) throws Throwable;

    protected abstract void endHookedMethod(MethodHookParam param) throws Throwable;

    @Override
    protected final void beforeHookedMethod(MethodHookParam param) throws Throwable {
        super.beforeHookedMethod(param);
        Log.d(TAG, "beforeHookedMethod: thisObject=" + param.thisObject.getClass().getName());
        Log.d(TAG, "beforeHookedMethod: method=" + param.method);
        Log.d(TAG, "beforeHookedMethod: args=" + Arrays.toString(param.args));

        // find interface instance index from MethodHookParam args
        try {
            Class<?>[] parameterTypes = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                parameterTypes = ((Executable) param.method).getParameterTypes();
            } else {
                try {
                    parameterTypes = ((Method) param.method).getParameterTypes();
                } catch (Throwable th) {
                    Log.e(TAG, "Failed to get parameter types: " + th);
                    try {
                        parameterTypes = ((Constructor) param.method).getParameterTypes();
                    } catch (Throwable th1) {
                        Log.e(TAG, "Failed to get parameter types: " + th);
                    }
                }
            }
            if (parameterTypes != null) {
                Log.d(TAG, "parameterTypes: " + Arrays.toString(parameterTypes));
                for (int i = 0; i < parameterTypes.length; ++i) {
                    Class type = parameterTypes[i];
                    if (type.isInterface()) {
                        callbackIndex = i;
                        Log.d(TAG, "Class [" + type + "] index is " + callbackIndex);
                        break;
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }

        Log.d(TAG, "begin call executeHookedMethod ...");
        Object result = executeHookedMethod(param);
        Log.d(TAG, "end call executeHookedMethod result: \'" + result + "\'");
        if (result != null) {
            param.setResult(result);
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
