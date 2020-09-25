package zizzy.zhao.bridgex.core.reflect;

import java.util.LinkedHashSet;
import java.util.Set;

public class ClassUtil {
    public static Class<?>[] extractClassesFromObjects(Object[] array) {
        if (array == null) {
            return null;
        } else if (array.length == 0) {
            return MiscUtil.EMPTY_CLASS_ARRAY;
        }
        final Class<?>[] classes = new Class[array.length];
        for (int i = 0; i < array.length; ++i) {
            classes[i] = (array[i] == null) ? null : array[i].getClass();
        }
        return classes;
    }

    public static Class<?>[] getAllInterfaces(Class<?> cls) {
        if (cls == null) {
            return null;
        }

        LinkedHashSet<Class<?>> interfaceSet = new LinkedHashSet<>();
        getAllInterfacesInternal(cls, interfaceSet);

        return interfaceSet.toArray(new Class[interfaceSet.size()]);
    }

    private static void getAllInterfacesInternal(Class<?> cls, Set<Class<?>> interfaceSet) {
        while (cls != null) {
            Class<?>[] interfaces = cls.getInterfaces();

            for (Class<?> itf : interfaces) {
                if (interfaceSet.add(itf)) {
                    getAllInterfacesInternal(itf, interfaceSet);
                }
            }

            cls = cls.getSuperclass();
        }
    }
}
