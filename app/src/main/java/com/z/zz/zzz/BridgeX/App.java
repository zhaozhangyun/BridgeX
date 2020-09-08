package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zhao.zizzy.bridgex.Reflactor;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        Reflactor.hookPMS(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }
}
