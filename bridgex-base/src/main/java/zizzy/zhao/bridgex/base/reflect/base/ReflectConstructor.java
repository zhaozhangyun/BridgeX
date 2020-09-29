package zizzy.zhao.bridgex.base.reflect.base;

import android.util.Log;

import java.lang.reflect.Constructor;

public class ReflectConstructor<T> {
    private static final String TAG = "ReflectConstructor";
    private final ReflectClass mClass;
    private final Constructor mConstructor;

    public ReflectConstructor(ReflectClass klass, Constructor constructor) {
        mClass = klass;
        mConstructor = constructor;
    }

    public T newInstance() {
        try {
            return (T) mConstructor.newInstance();
        } catch (Exception e) {
            Log.e(TAG, "newInstance error: ", e);
            return null;
        }
    }

    public T newInstance(Object... params) {
        try {
            return (T) mConstructor.newInstance(params);
        } catch (Exception e) {
            Log.e(TAG, "newInstance error: ", e);
            return null;
        }
    }

    @Override
    public String toString() {
        return "ReflectConstructor{" +
                "mClass=" + mClass +
                ", mConstructor=" + mConstructor +
                '}';
    }
}
