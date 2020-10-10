package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
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
            Object ctor = MltAdMethodHookDelegate.constructor.newInstance();
            MltAdMethodHookDelegate.install.invoke(ctor, this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
