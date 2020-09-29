package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Constructor;

public class ReflectConstructor<T> {
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
            return null;
        }
    }

    public T newInstance(Object... params) {
        try {
            return (T) mConstructor.newInstance(params);
        } catch (Exception e) {
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
