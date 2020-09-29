package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Field;

public class ReflectObjectField<T> extends ReflectField {
    public ReflectObjectField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public T get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public T get(Object object) {
        try {
            return (T) mField.get(object);
        } catch (Exception e) {
            return null;
        }
    }

    public void set(T value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, T value) {
        try {
            mField.set(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
