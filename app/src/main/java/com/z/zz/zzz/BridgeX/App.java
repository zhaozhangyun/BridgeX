package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.core.LogBridge;
import zizzy.zhao.bridgex.core.Logger;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        BridgeX.attach(base);
        LogBridge.log(base);

        Logger.d(base);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }

}
