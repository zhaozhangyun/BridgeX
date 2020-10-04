package zizzy.zhao.bridgex.base.reflect.base;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class ReflectClass {
    private Class<?> mClass;

    public static ReflectClass load(String className) throws ClassNotFoundException {
        return new ReflectClass(Class.forName(className));
    }

    public static ReflectClass load(Class<?> klass) {
        return new ReflectClass(klass);
    }

    public Class<?> getOrigClass() {
        return mClass;
    }

    private ReflectClass(Class<?> klass) {
        mClass = klass;
    }

    public String getName() {
        return mClass.getPackage() + "." + mClass.getName();
    }

    public ReflectConstructor getDefaultConstructor()
            throws NoSuchMethodException {
        Constructor constructor = mClass.getDeclaredConstructor();
        constructor.setAccessible(true);
        return new ReflectConstructor(this, constructor);
    }

    public ReflectConstructor getConstructor(Class... paramTypes)
            throws NoSuchMethodException {
        Constructor constructor = mClass.getDeclaredConstructor(paramTypes);
        constructor.setAccessible(true);
        return new ReflectConstructor(this, constructor);
    }

    public ReflectMethod getDeclaredMethod(String name, Class<?>... argTypes)
            throws NoSuchMethodException {
        Method method = null;

        try {
            method = mClass.getMethod(name, argTypes);
        } catch (NoSuchMethodException e) {
            do {
                try {
                    method = mClass.getDeclaredMethod(name, argTypes);
                } catch (NoSuchMethodException ignore) {
                }

                mClass = mClass.getSuperclass();
            } while (mClass != null);

            if (method == null) {
                throw new NoSuchMethodException();
            }
        }

        method.setAccessible(true);

        return new ReflectMethod(this, method);
    }

    public ReflectField getDeclaredField(String name) throws NoSuchFieldException {
        Field field = mClass.getDeclaredField(name);
        field.setAccessible(true);

        if (!field.getType().isPrimitive()) {
            return new ReflectObjectField(this, field);
        } else {
            if (field.getType() == Boolean.TYPE) {
                return new ReflectBooleanField(this, field);
            } else if (field.getType() == Integer.TYPE) {
                return new ReflectIntField(this, field);
            } else if (field.getType() == Long.TYPE) {
                return new ReflectLongField(this, field);
            } else if (field.getType() == Float.TYPE) {
                return new ReflectFloatField(this, field);
            } else if (field.getType() == Double.TYPE) {
                return new ReflectDoubleField(this, field);
            }
        }

        return null;
    }

    @Override
    public String toString() {
        return "ReflectClass{" +
                "mClass=" + mClass +
                '}';
    }
}
