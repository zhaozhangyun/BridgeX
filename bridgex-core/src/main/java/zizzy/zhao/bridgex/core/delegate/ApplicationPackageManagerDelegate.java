package zizzy.zhao.bridgex.core.delegate;

import android.os.IInterface;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectObjectField;

public class ApplicationPackageManagerDelegate {
    private static ReflectClass sClass = null;
    public static ReflectObjectField<IInterface> mPM;

    static {
        try {
            initialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
    }

    private static void initialize() throws ClassNotFoundException,
            NoSuchFieldException {
        sClass = ReflectClass.load("android.app.ApplicationPackageManager");

        mPM = (ReflectObjectField<IInterface>) sClass.getDeclaredField("mPM");
    }

    public static Class getOrigClass() {
        return sClass.getOrigClass();
    }
}
