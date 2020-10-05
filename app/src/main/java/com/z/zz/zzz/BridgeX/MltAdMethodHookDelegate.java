package com.z.zz.zzz.BridgeX;

import android.content.Context;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;

public class MltAdMethodHookDelegate {
    private static ReflectClass sClass = null;
    public static ReflectConstructor constructor;
    public static ReflectMethod install;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException, NoSuchMethodException {
        sClass = ReflectClass.load("zizzy.zhao.bridgex.hook.module.mltad.MltAdHook");

        constructor = sClass.getDefaultConstructor();

        install = sClass.getDeclaredMethod(
                "install",
                Context.class
        );
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }
}
