package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.hook.HookBridge;
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

//        try {
//            System.loadLibrary("bridgex-core");
//        } catch (Throwable th) {
//            th.printStackTrace();
//        }

        BridgeX.attach(this);

        HookBridge.executeHook(
                MainActivity.class.getName(),
                "fuckBridge",
                "Ljava/lang/String;",
                "zizzy.zhao.bridgex.hook.module.mltad.MltAdMethodHook"
        );
    }
}
