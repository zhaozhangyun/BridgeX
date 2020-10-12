package zizzy.zhao.bridgex.hook.module.ttads;

import android.content.Context;

import zizzy.zhao.bridgex.hook.XCHook;

public class TTAdConfigHook extends XCHook {

    @Override
    protected void bindXCMethods(Context context) {
        executeHook(
                TTAdConfigDelegate.getOrigClass().getName(),
                TTAdConfigDelegate.getAppId.getName(),
                "",
                TTAdConfigMethodHook.class
        );
    }
}
