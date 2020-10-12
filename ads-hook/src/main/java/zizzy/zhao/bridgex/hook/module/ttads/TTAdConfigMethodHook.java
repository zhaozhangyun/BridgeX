package zizzy.zhao.bridgex.hook.module.ttads;

import zizzy.zhao.bridgex.base.utils.Util;
import zizzy.zhao.bridgex.hook.XCMethodHook;

public class TTAdConfigMethodHook extends XCMethodHook {

    @Override
    protected Object executeHookedMethod(MethodHookParam param) throws Throwable {
        if (TTAdConfigDelegate.getAppId.getName().equals(param.method.getName())) {
            String appId = Util.getMateData(getActivity(),
                    "bridgex.com_bytedance_sdk_openadsdk-hook-appid");
            return appId;
        }
        return null;
    }

    @Override
    protected void endHookedMethod(MethodHookParam param) throws Throwable {
    }
}
