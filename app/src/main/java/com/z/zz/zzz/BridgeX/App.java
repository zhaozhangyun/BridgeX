package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.hook.XCMethodHookDelegate;
import zizzy.zhao.bridgex.multidex.MultiDeX;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDeX.install(base);
    }

    @Override
    public void onCreate() {
        super.onCreate();

        BridgeX.attach(this);

        try {
            XCMethodHookDelegate delegate = new XCMethodHookDelegate();
            delegate.install("zizzy.zhao.bridgex.hook.module.mltad.MltAdHook", this);
        } catch (Throwable th) {
            th.printStackTrace();
        }

        foo();
    }

    private void foo() {
        try {
            XCMethodHookDelegate delegate = new XCMethodHookDelegate();
            delegate.install("zizzy.zhao.bridgex.hook.module.ttads.TTAdConfigHook", this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
