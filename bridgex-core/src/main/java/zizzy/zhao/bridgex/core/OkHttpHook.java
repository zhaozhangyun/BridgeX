package zizzy.zhao.bridgex.core;

import android.content.Context;

import zizzy.zhao.bridgex.core.delegate.OkHttpClientDelegate;
import zizzy.zhao.bridgex.hook.XCHook;

public class OkHttpHook extends XCHook {

    @Override
    protected void bindXCMethods(Context context) {
        executeHook(
                OkHttpClientDelegate.Builder.getOrigClass().getName(),
                "<init>",
                "()V",
                OkHttpMethodHook.class
        );
    }
}
