package zizzy.zhao.bridgex.core.reflect.base;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

public class ReflectField {
    protected final ReflectClass mClass;
    protected final Field mField;
    protected final boolean mIsStatic;

    public ReflectField(ReflectClass klass, Field field) {
        mClass = klass;
        mField = field;

        mIsStatic = Modifier.isStatic(mField.getModifiers());
    }

    public boolean isStatic() {
        return mIsStatic;
    }

    public Class<?> getType() {
        return mField.getType();
    }

    @Override
    public String toString() {
        return "ReflectField{" +
                "mClass=" + mClass +
                ", mField=" + mField +
                ", mIsStatic=" + mIsStatic +
                '}';
    }
}
