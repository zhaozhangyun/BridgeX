package zizzy.zhao.bridgex.core.delegate;

import android.util.Log;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;

public class OkHttpClientDelegate {
    private static ReflectClass sClass = null;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException {
        sClass = ReflectClass.load("okhttp3.OkHttpClient");
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }

    public static class Builder {
        private static ReflectClass sClass = null;
        public static ReflectMethod<Builder> addNetworkInterceptor;

        static {
            try {
                initialize();
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException();
            }
        }

        private static void initialize() throws ClassNotFoundException, NoSuchMethodException {
            sClass = ReflectClass.load("okhttp3.OkHttpClient$Builder");
            addNetworkInterceptor = sClass.getDeclaredMethod(
                    "addNetworkInterceptor",
                    ReflectClass.load("okhttp3.Interceptor").getOrigClass()
            );
            Log.d("OkHttpClientDelegate", "addNetworkInterceptor -> " + addNetworkInterceptor);
        }

        public static Class getOrigClass() {
            return sClass.getOrigClass();
        }
    }
}
