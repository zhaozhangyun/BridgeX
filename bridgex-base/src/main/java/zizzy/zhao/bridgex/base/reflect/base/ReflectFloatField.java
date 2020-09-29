package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Field;

public class ReflectFloatField extends ReflectField {
    public ReflectFloatField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public float get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public float get(Object object) {
        try {
            return mField.getFloat(object);
        } catch (Exception e) {
            return 0;
        }
    }

    public void set(float value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, float value) {
        try {
            mField.setFloat(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
