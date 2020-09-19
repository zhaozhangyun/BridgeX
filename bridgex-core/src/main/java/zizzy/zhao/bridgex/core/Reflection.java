package zizzy.zhao.bridgex.core;

import android.os.Build;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class Reflection {

    private static final String TAG = "Reflection";

    static {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            HiddenApiWrapper.exemptAll();
        }
    }

    public static Class forName(String className) {
        try {
            return Class.forName(className);
        } catch (Throwable t) {
            Log.e("Reflection", "Failed to find class: " + t.getMessage());
            return null;
        }
    }

    public static Object createDefaultInstance(String className) {
        Class classObject = forName(className);
        if (classObject == null) {
            return null;
        }

        return createDefaultInstance(classObject);
    }

    public static Object createDefaultInstance(Class classObject) {
        try {
            return classObject.newInstance();
        } catch (Throwable t) {
            t.printStackTrace();
            return null;
        }
    }

    public static Object createInstance(String className, Class[] cArgs, Object... args) {
        try {
            Class classObject = Class.forName(className);
            @SuppressWarnings("unchecked")
            Constructor constructor = classObject.getConstructor(cArgs);
            return constructor.newInstance(args);
        } catch (Throwable t) {
            t.printStackTrace();
            return null;
        }
    }

    public static Object invokeStaticMethod(String className, String methodName, Class[] cArgs,
                                            Object... args) throws Exception {
        Class classObject = Class.forName(className);
        return invokeMethod(classObject, methodName, null, cArgs, args);
    }

    public static Object invokeInstanceMethod(Object instance, String methodName, Class[] cArgs,
                                              Object... args) throws Exception {
        Class classObject = instance.getClass();
        return invokeMethod(classObject, methodName, instance, cArgs, args);
    }

    public static Object invokeMethod(Class classObject, String methodName, Object instance,
                                      Class[] cArgs, Object... args) throws Exception {
        @SuppressWarnings("unchecked")
        Method methodObject = classObject.getDeclaredMethod(methodName, cArgs);
        Log.v(TAG, "[invokeMethod] get method is: " + methodObject);
        if (methodObject == null) {
            return null;
        }

        return methodObject.invoke(instance, args);
    }

    public static Object readField(String className, String fieldName) throws Exception {
        return readField(className, fieldName, null);
    }

    public static Object readField(String className, String fieldName, Object instance)
            throws Exception {
        Class classObject = forName(className);
        if (classObject == null) {
            return null;
        }
        Field fieldObject = classObject.getDeclaredField(fieldName);
        if (fieldObject == null) {
            return null;
        }
        return fieldObject.get(instance);
    }

    public static void writeField(String className, String filedName, Object filedValue)
            throws Exception {
        writeField(className, filedName, null, filedValue);
    }

    public static void writeField(String className, String filedName, Object instance,
                                  Object filedValue) throws Exception {
        Class classObject = forName(className);
        if (classObject == null) {
            return;
        }
        Field fieldObject = classObject.getDeclaredField(filedName);
        if (fieldObject == null) {
            return;
        }
        fieldObject.setAccessible(true);
        fieldObject.set(instance, filedValue);
    }
}
