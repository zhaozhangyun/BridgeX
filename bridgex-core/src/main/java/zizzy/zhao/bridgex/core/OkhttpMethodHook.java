package zizzy.zhao.bridgex.core;

import android.util.Log;

import java.util.Arrays;

import zizzy.zhao.bridgex.hook.XCMethodHook;

public class OkhttpMethodHook extends XCMethodHook {
    private static final String TAG = "OkhttpMethodHook";

    public OkhttpMethodHook(Class[] srcArgs) {
        super(srcArgs);
    }

    @Override
    protected Object executeHookedMethod(MethodHookParam param) {
        Log.d(TAG, "beforeHookedMethod: method=" + param.method);
        Log.d(TAG, "beforeHookedMethod: args=" + Arrays.toString(param.args));
        return null;
    }

    @Override
    protected void endHookedMethod(MethodHookParam param) {
        Log.d(TAG, "endHookedMethod: method=" + param.method);
        Log.d(TAG, "endHookedMethod: args=" + Arrays.toString(param.args));
    }
}
