package zizzy.zhao.bridgex.base.reflect;

import java.lang.reflect.Method;

public class MethodUtil {
    public static boolean isMethodDeclaredThrowable(Method method, Throwable exception) {
        if (exception instanceof RuntimeException) {
            return true;
        }

        if ((method == null)
                || (exception == null)) {
            return false;
        }

        Class[] methodExceptionClasses = method.getExceptionTypes();
        if (methodExceptionClasses.length == 0) {
            return false;
        }

        for (Class exceptionClass : methodExceptionClasses) {
            if (exceptionClass.isInstance(exception)
                    || exceptionClass.isAssignableFrom(exceptionClass.getClass())) {
                return true;
            }
        }
        return false;
    }

    public static int indexOfFirstArgType(Object[] args, Class clazz) {
        return indexOfFirstArgType(args, clazz, 0);
    }

    public static int indexOfFirstArgType(Object[] args, Class clazz, int startIdx) {
        if ((args != null)
                && (args.length > 0)) {
            for (int i=startIdx; i<args.length; ++i) {
                Object obj = args[i];
                if ((obj != null)
                        && (obj.getClass() == clazz)) {
                    return i;
                }
            }
        }
        return -1;
    }

    public static int indexOfLastArgType(Object[] args, Class clazz) {
        if ((args != null)
                && (args.length > 0)) {
            for (int i=args.length-1; i>=0; --i) {
                Object obj = args[i];
                if ((obj != null)
                        && (obj.getClass() == clazz)) {
                    return i;
                }
            }
        }
        return -1;
    }

    public static int indexOfFirstArgInstance(Object[] args, Class clazz) {
        return indexOfFirstArgInstance(args, clazz, 0);
    }

    public static int indexOfFirstArgInstance(Object[] args, Class clazz, int startIdx) {
        if (args != null) {
            for (int i=startIdx; i<args.length; ++i) {
                Object obj = args[i];
                if ((obj != null)
                        && clazz.isInstance(obj)) {
                    return i;
                }
            }
        }
        return -1;
    }
}
