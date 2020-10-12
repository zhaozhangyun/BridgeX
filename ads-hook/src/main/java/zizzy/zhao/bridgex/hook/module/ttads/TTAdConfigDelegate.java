package zizzy.zhao.bridgex.hook.module.ttads;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;

public class TTAdConfigDelegate {
    private static ReflectClass sClass = null;
    public static ReflectMethod getAppId;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException, NoSuchMethodException {
        sClass = ReflectClass.load("com.bytedance.sdk.openadsdk.TTAdConfig");

        getAppId = sClass.getDeclaredMethod(
                "getAppId"
        );
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }
}
