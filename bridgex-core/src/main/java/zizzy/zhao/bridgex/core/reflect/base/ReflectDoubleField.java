package zizzy.zhao.bridgex.core.reflect.base;

import java.lang.reflect.Field;

public class ReflectDoubleField extends ReflectField {
    public ReflectDoubleField(ReflectClass klass, Field field) {
        super(klass, field);
    }

    public double get() {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        return get(null);
    }

    public double get(Object object) {
        try {
            return mField.getDouble(object);
        } catch (Exception e) {
            return 0;
        }
    }

    public void set(double value) {
        if (!isStatic()) {
            throw new RuntimeException();
        }

        set(null, value);
    }

    public void set(Object obj, double value) {
        try {
            mField.setDouble(obj, value);
        } catch (Exception e) {
            //Ignore
        }
    }
}
