package com.z.zz.zzz.BridgeX;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import zizzy.zhao.bridgex.core.LogBridge;
import zizzy.zhao.bridgex.l.L;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//        startActivity(new Intent(Intent.ACTION_VIEW,
//                Uri.parse("sinaweibo://cardlist?containerid=102803" +
//                        "&extparam=from_push_-_mid_4564277162148357_-_category_1760" +
//                        "&need_head_cards=1" +
//                        "&luicode=10000404" +
//                        "&lfid=gtpl_9999_shipin084" +
//                        "&launchid=10000404-gtpl_9999_shipin084")));

        checkAPP(this);

        SensorManager sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        sensorManager.getSensors();
        List<Sensor> sensorList = sensorManager.getSensorList(Sensor.TYPE_ALL);
        L.d(sensorList);

//        LogBridge.log();
//        LogBridge.log("hello, world");
//        LogBridge.logFormat("%d, %s, %s, %s", 1, "call create", "call create1", "uin");
//        LogBridge.log("{ when=0 what=3 target=com.bytedance.sdk.openadsdk.utils.WeakHandler }");
//        LogBridge.log(1);
//        LogBridge.log(true);
//        LogBridge.log(1.0f);
//        LogBridge.log(10000000000000000L);
//        LogBridge.log("abc", "lalala");
//        LogBridge.logs(123, "hello", true, "jk123");

        Bundle bundle = new Bundle();
        bundle.putString("key1", "hello");
        bundle.putInt("key2", 666);
        bundle.putBoolean("key3", true);
//        LogBridge.log(bundle);

        L.d("123");
        L.d(123);
        L.d(123L);
        L.d(123.00);
        L.d(true);
        L.d(new String[]{"123", "321"});
        L.d(new int[]{123, 321});
        L.d(bundle);
        L.logs(123, "hello", true, "jk123");
        L.printlnF("%d, %s, %s, %s", 1, "call create", "call create1", "uin");

        InputStream is = null;
        try {
            is = getResources().getAssets().open("bridgex_conf.json");
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            final JSONObject json = new JSONObject(new String(buffer));
            new Thread(() -> {
//                LogBridge.log(json);
                L.d(json);

                for (int i = 0; i < 3; i++) {
//                    LogBridge.log(Thread.currentThread().getName() + i, json);
                    L.d(json);
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
            Log.i("test", "signText : " + sign.toCharsString());
            Log.i("test", "hashCode : " + hashcode);
            Log.i("test", "packageName : " + packageInfo.packageName);
            Log.i("test", "packageVersionName : " + packageInfo.versionName);
            Log.i("test", "packageVersionCode : " + packageInfo.versionCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    void send_data(final String data) {
        URL url = null;
        try {
            url = new URL("http://192.168.18.134");
            final HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                        out.writeBytes(enc(data));
                        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                        final String text = in.readLine();
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
//                                ((TextView) findViewById(R.id.textView)).setText(text);
//                                dec(text);
                            }
                        });
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    String enc(String data) {
        try {
            String pre_shared_key = "aaaaaaaaaaaaaaaa"; //assume that this key was not hardcoded
            String generated_iv = "bbbbbbbbbbbbbbbb";
            Cipher my_cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            my_cipher.init(Cipher.ENCRYPT_MODE,
                    new SecretKeySpec(pre_shared_key.getBytes("UTF-8"), "AES"),
                    new IvParameterSpec(generated_iv.getBytes("UTF-8")));
            byte[] x = my_cipher.doFinal(data.getBytes());
            System.out.println(new String(Base64.encode(x, Base64.DEFAULT)));
            return new String(Base64.encode(x, Base64.DEFAULT));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        }
        return null;
    }

    String dec(String data) {
        try {
            byte[] decoded_data = Base64.decode(data.getBytes(), Base64.DEFAULT);
            String pre_shared_key = "aaaaaaaaaaaaaaaa"; //assume that this key was not hardcoded
            String generated_iv = "bbbbbbbbbbbbbbbb";
            Cipher my_cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            my_cipher.init(Cipher.DECRYPT_MODE,
                    new SecretKeySpec(pre_shared_key.getBytes("UTF-8"), "AES"),
                    new IvParameterSpec(generated_iv.getBytes("UTF-8")));
            String plain = new String(my_cipher.doFinal(decoded_data));
            return plain;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        }
        return "";
    }

    @NonNull
    @Override
    public String toString() {
        return "fuck frida!!!";
    }
}
