package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Field;

public class ReflectLongField extends ReflectField {
    public ReflectLongField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public long get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public long get(Object object) {
        try {
            return mField.getLong(object);
        } catch (Exception e) {
            return 0;
        }
    }

    public void set(long value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, long value) {
        try {
            mField.setLong(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
