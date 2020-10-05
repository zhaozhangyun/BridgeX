package zizzy.zhao.bridgex.hook.module.mltad;

import android.content.Context;

import com.mltad.liby.MLTAdSDK;

import zizzy.zhao.bridgex.hook.XCHook;

public class MltAdHook extends XCHook {

    @Override
    protected void init(Context context) {
        MLTAdSDK.init(context, MLTADCfg.MLTAD_APPID);
    }

    @Override
    protected void bindXCMethods(Context context) {
        executeHook(
                "com.z.zz.zzz.BridgeX.MainActivity",
                "fuckBridge",
                "Ljava/lang/String;",
                MltRewardVideoAdHook.class
        );
    }
}
