package zizzy.zhao.bridgex.core.reflect.delegate;

import android.os.IInterface;

import zizzy.zhao.bridgex.core.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.core.reflect.base.ReflectObjectField;

public final class ActivityThreadDelegate {
    private static ReflectClass sClass = null;
    public static ReflectObjectField<IInterface> sPackageManager;
    public static ReflectObjectField<Object> sCurrentActivityThread;

    static {
        try {
            initialize();
        } catch (Throwable th) {
            th.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws Throwable {
        sClass = ReflectClass.load("android.app.ActivityThread");

        sPackageManager = (ReflectObjectField<IInterface>) sClass.getDeclaredField("sPackageManager");
        sCurrentActivityThread = (ReflectObjectField<Object>) sClass.getDeclaredField("sCurrentActivityThread");
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }
}
