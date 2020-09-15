package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.multidex.AssetsMultiDex;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
    }

    @Override
    public void onCreate() {
        super.onCreate();

//        try {
//            System.loadLibrary("bridgex-core");
//        } catch (Throwable th) {
//            th.printStackTrace();
//        }

        try {
            AssetsMultiDex.install(this, "bridgex-dex");
        } catch (Exception e) {
            e.printStackTrace();
        }
        BridgeX.attach(this);
    }
}
