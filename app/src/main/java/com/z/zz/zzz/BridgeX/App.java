package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.core.LogBridge;
import zizzy.zhao.bridgex.l.L;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        BridgeX.attach(base);
        LogBridge.init(this);
        LogBridge.log(this);
        L.attach(this);
        L.d(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }

}
