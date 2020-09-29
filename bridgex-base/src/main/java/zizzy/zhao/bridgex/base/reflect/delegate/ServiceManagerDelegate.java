package zizzy.zhao.bridgex.base.reflect.delegate;

import android.os.Build;
import android.os.IBinder;

import java.util.HashMap;

import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;
import zizzy.zhao.bridgex.base.reflect.base.ReflectObjectField;
import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;

public final class ServiceManagerDelegate {
    private static ReflectClass sClass = null;
    public static ReflectObjectField<HashMap<String, IBinder>> sCache = null;
    public static ReflectMethod<IBinder> getService = null;
    public static ReflectMethod<IBinder> getServiceOrThrow = null;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException, NoSuchFieldException,
            NoSuchMethodException {
        sClass = ReflectClass.load("android.os.ServiceManager");

        sCache = (ReflectObjectField<HashMap<String, IBinder>>) sClass.getDeclaredField("sCache");

        getService = (ReflectMethod<IBinder>) sClass.getDeclaredMethod("getService", String.class);

        if (/*BuildConfig.DEBUG &&*/ Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            getServiceOrThrow = (ReflectMethod<IBinder>) sClass.getDeclaredMethod("getServiceOrThrow", String.class);
        }
    }

    public static ReflectClass getOrigClass() {
        return sClass;
    }
}
