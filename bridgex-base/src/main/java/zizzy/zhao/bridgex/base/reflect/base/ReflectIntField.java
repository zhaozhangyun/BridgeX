package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Field;

public class ReflectIntField extends ReflectField {
    public ReflectIntField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public int get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public int get(Object object) {
        try {
            return mField.getInt(object);
        } catch (Exception e) {
            return 0;
        }
    }

    public void set(int value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, int value) {
        try {
            mField.setInt(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
