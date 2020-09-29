package zizzy.zhao.bridgex.core.delegate;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;

public class StethoInterceptorDelegate {
    private static ReflectClass sClass = null;
    public static ReflectConstructor constructor;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException, NoSuchMethodException {
        sClass = ReflectClass.load("com.facebook.stetho.okhttp3.StethoInterceptor");

        constructor = sClass.getDefaultConstructor();
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }
}
