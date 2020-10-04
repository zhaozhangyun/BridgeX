package zizzy.zhao.bridgex.core;

import android.content.Context;
import android.util.Log;

import zizzy.zhao.bridgex.core.delegate.OkHttpClientDelegate;
import zizzy.zhao.bridgex.core.delegate.StethoInterceptorDelegate;
import zizzy.zhao.bridgex.hook.HookBridge;
import zizzy.zhao.bridgex.hook.XCMethodHook;

public class OkHttpMethodHook extends XCMethodHook {
    private static final String TAG = "OkHttpMethodHook";

    @Override
    protected Object executeHookedMethod(MethodHookParam param) throws Throwable {
        return null;
    }

    @Override
    protected void endHookedMethod(MethodHookParam param) throws Throwable {
        Object stethoInterceptorIns = StethoInterceptorDelegate.constructor.newInstance();
        Log.d(TAG, "stethoInterceptorIns: " + stethoInterceptorIns);
        OkHttpClientDelegate.Builder.addNetworkInterceptor.invoke(
                param.thisObject,
                stethoInterceptorIns
        );
    }

    @Override
    protected void bindMethodProxies(Context context) {
        HookBridge.executeHook(
                OkHttpClientDelegate.Builder.getOrigClass().getName(),
                "<init>",
                "()V",
                getClass()
        );
    }
}
