package com.z.zz.zzz.BridgeX;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;

import zhao.zizzy.bridgex.BridgeX;
import zhao.zizzy.bridgex.LogBridge;
import zhao.zizzy.bridgex.Logger;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        checkAPP(this);

        LogBridge.inject(new LoggerImpl());

        BridgeX.attach(this);

        Logger.log();
        Logger.log("hello, world");
        Logger.log(1, "call create", "call create1", "uin");
        Logger.log("{ when=0 what=3 target=com.bytedance.sdk.openadsdk.utils.WeakHandler }");
        Logger.log(1);
        Logger.log(true);
        Logger.log(1.0f);
        Logger.log(10000000000000000L);
        Logger.log("abc", "lalala");
        fuckBridge("fuck !!!");

        InputStream is = null;
        try {
            is = getResources().getAssets().open("bridgex_conf.json");
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            final JSONObject json = new JSONObject(new String(buffer));
            new Thread(new Runnable() {
                @Override
                public void run() {
                    for (int i = 0; i < 3; i++) {
                        Logger.log(Thread.currentThread().getName(), json);
                    }
                }
            }, "thread-a").start();
        } catch (Throwable th) {
            // ignored
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                }
            }
        }

//        try {
//            is = getResources().getAssets().open("package_pattern.json");
//            int size = is.available();
//            byte[] buffer = new byte[size];
//            is.read(buffer);
//            final JSONObject json = new JSONObject(new String(buffer));
//            new Thread(new Runnable() {
//                @Override
//                public void run() {
//                    for (int i = 0; i < 3; i++) {
//                        Logger.log(Thread.currentThread().getName(), json);
//                    }
//                }
//            }, "thread-b").start();
//        } catch (Throwable th) {
//            // ignored
//        } finally {
//            if (is != null) {
//                try {
//                    is.close();
//                } catch (IOException e) {
//                }
//            }
//        }

//        BridgeX.writeToFile("test.txt", "abc");
    }

    private void fuckBridge(String fuck) {
        Logger.log();
        Logger.log(fuck);
        Logger.log("sick", fuck);
    }

    private void checkAPP(Context context) {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(
                    context.getPackageName(), PackageManager.GET_SIGNATURES);
            Signature[] signs = packageInfo.signatures;
            Signature sign = signs[0];
            int hashcode = sign.hashCode();
            Log.i("test", "hashCode : " + hashcode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
