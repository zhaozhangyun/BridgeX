package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Field;

public class ReflectBooleanField extends ReflectField {
    public ReflectBooleanField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public boolean get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public boolean get(Object object) {
        try {
            return mField.getBoolean(object);
        } catch (Exception e) {
            return false;
        }
    }

    public void set(boolean value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, boolean value) {
        try {
            mField.setBoolean(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
