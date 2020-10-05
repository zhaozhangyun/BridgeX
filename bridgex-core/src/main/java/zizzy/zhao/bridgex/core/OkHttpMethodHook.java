package zizzy.zhao.bridgex.core;

import zizzy.zhao.bridgex.core.delegate.OkHttpClientDelegate;
import zizzy.zhao.bridgex.core.delegate.StethoInterceptorDelegate;
import zizzy.zhao.bridgex.hook.XCMethodHook;

public class OkHttpMethodHook extends XCMethodHook {

    @Override
    protected Object executeHookedMethod(MethodHookParam param) throws Throwable {
        return null;
    }

    @Override
    protected void endHookedMethod(MethodHookParam param) throws Throwable {
        Object stethoInterceptorIns = StethoInterceptorDelegate.constructor.newInstance();
        OkHttpClientDelegate.Builder.addNetworkInterceptor.invoke(
                param.thisObject,
                stethoInterceptorIns
        );
    }
}
