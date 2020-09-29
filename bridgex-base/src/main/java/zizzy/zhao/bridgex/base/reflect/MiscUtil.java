package zizzy.zhao.bridgex.base.reflect;

public class MiscUtil {
    public static final Object[] EMPTY_OBJECT_ARRAY = new Object[0];
    public static final Class<?>[] EMPTY_CLASS_ARRAY = new Class[0];

    public static Class<?>[] nullToEmptyClassArray(Class<?>[] array) {
        if ((array == null) || (array.length == 0)) {
            return EMPTY_CLASS_ARRAY;
        } else {
            return array;
        }
    }

    public static Object[] nullToEmptyObjectArray(Object[] array) {
        if ((array == null) || (array.length == 0)) {
            return EMPTY_OBJECT_ARRAY;
        } else {
            return array;
        }
    }
}
