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

import zizzy.zhao.bridgex.core.LogBridge;
import zizzy.zhao.bridgex.core.Logger;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        checkAPP(this);

        LogBridge.log();
        LogBridge.log("hello, world");
        LogBridge.logFormat("%d, %s, %s, %s", 1, "call create", "call create1", "uin");
        LogBridge.log("{ when=0 what=3 target=com.bytedance.sdk.openadsdk.utils.WeakHandler }");
        LogBridge.log(1);
        LogBridge.log(true);
        LogBridge.log(1.0f);
        LogBridge.log(10000000000000000L);
        LogBridge.log("abc", "lalala");
        LogBridge.logs(123, "hello", true, "jk123");

        Bundle bundle = new Bundle();
        bundle.putString("key1", "hello");
        bundle.putInt("key2", 666);
        bundle.putBoolean("key3", true);
        LogBridge.log(bundle);

        Logger.log("123");
        Logger.log(123);
        Logger.log(123L);
        Logger.log(123.00);
        Logger.log(true);
        Logger.log(new String[]{"123", "321"});
        Logger.log(new int[]{123, 321});
        Logger.log(bundle);
        Logger.logs(123, "hello", true, "jk123");
        Logger.printlnF("%d, %s, %s, %s", 1, "call create", "call create1", "uin");

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
                    LogBridge.log(json);

                    for (int i = 0; i < 3; i++) {
                        LogBridge.log(Thread.currentThread().getName() + i, json);
                        Logger.log(json);
                    }
                }
            }, "thread-").start();
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
//                        LogBridge.log(Thread.currentThread().getName(), json);
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

        fuckBridge("fuck !!!");
    }

    private void fuckBridge(String fuck) {
        LogBridge.log();
        LogBridge.log(fuck);
        LogBridge.log("sick", fuck);
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
