package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;
import android.os.IBinder;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.core.BridgeX;
import zizzy.zhao.bridgex.hook.XCMethodHook;
import zizzy.zhao.bridgex.hook.module.mltad.MltAdMethodHook;
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

        try {
            Object ctor = MltAdMethodHookDelegate.constructor.newInstance();
            MltAdMethodHookDelegate.install.invoke(ctor, this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
