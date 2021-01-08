package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.core.LogBridge;
import zizzy.zhao.bridgex.hook.XCMethodHookDelegate;
import zizzy.zhao.bridgex.multidex.MultiDeX;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDeX.install(base);

        BridgeX.attach(base);
        LogBridge.log(base);
    }

    @Override
    public void onCreate() {
        super.onCreate();

        XCMethodHookDelegate.install("zizzy.zhao.bridgex.hook.module.mltad.MltAdHook", this);

        foo();
    }

    private void foo() {
        XCMethodHookDelegate.install("zizzy.zhao.bridgex.hook.module.ttads.TTAdConfigHook", this);
    }
}
