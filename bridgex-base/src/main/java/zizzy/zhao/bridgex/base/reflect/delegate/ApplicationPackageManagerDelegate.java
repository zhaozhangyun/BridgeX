package zizzy.zhao.bridgex.base.reflect.delegate;

import android.os.IInterface;

import zizzy.zhao.bridgex.base.reflect.base.ReflectObjectField;
import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;

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
