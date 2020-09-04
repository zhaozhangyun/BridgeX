package com.z.zz.zzz.BridgeX;

import android.app.Application;
import android.content.Context;

import zhao.zizzy.bridgex.Reflactor;

public class App extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        String signed = "308202f9308201e1a003020102020414e3675b300d06092a864886f70d01010b0500302c310c300a06035504061303787878310c300a060355040a1303787878310e300c060355040313054a416c65783020170d3132313131353038323834325a180f33303132303331383038323834325a302c310c300a06035504061303787878310c300a060355040a1303787878310e300c060355040313054a416c657830820122300d06092a864886f70d01010105000382010f003082010a0282010100905b780d8fb4c77f126fb6377a0ab02280f3aa2dbc084c4c119a4b0b9da42b9181fe6e87de4cf8fd5c606c442cb228feacacdccfc0db776d34d4b21be5f57e72e6b224af7a70519bc787f9e926fad8baddd7b05c59e96ab3f8ee51472c6c29725c520353aa63dff94ca2b480e51345024c77b81d84301240ff8b67c48ded9b83b3332970f5eac9523f9b54794cb16468513e189ebebd46fa8ef674be51a9d74985986326acc5d90c389a65ecd22d525bf62b81aae265aac383dc3bdefc3fa8e7099b3ae25046eaebf7fc05e6e6b5a97ad9f28c918459d10d8cd03f5dda2b962aba05b893c2e44aae020e66f6e3263c5e265998e2275708fa6ed39c0b9c23105b0203010001a321301f301d0603551d0e04160414ad3341b5e3e7e43bdddf615c007b60528c5d2f7e300d06092a864886f70d01010b050003820101002d819ad746e817faa7b58b61aa63c5aec428a7487377f11bc14757c4183fa9897037df720088da30b5f0db1e029f90bb03c57a8f47adc843267c94faa7121b9987c5fc7f0f445cedbc6f3a86a89ae3a823828bea0dc594622407ba35eb6ee8d4fed404e53bcb6608391ca34b6407a7ea794a5506202d2dabb9ca9b68f1045d95677197b42de24df09485e315407ceda0d206ce53250914e1e0acd8639856f963a13ca14573563490f1822749137c4ca341a0397335e7c11eeb017bf80f3f47fe4c9e719d12afcfe985aaff344a99e58f2a478786e1476805dcba227d592463c1fbb18781a2aed1e7c046cbb7d2b1b06d7e4c9dd68ef6f7d5f4efb06c4d5c6c04";
        Reflactor.hookPMS(this, signed);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }
}
