package zizzy.zhao.bridgex.base.reflect.base;

import android.util.Log;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;

public class ReflectMethod<T> {
    private final ReflectClass mClass;
    private final Method mMethod;
    private final boolean mIsStatic;

    ReflectMethod(ReflectClass klass, Method method) {
        mClass = klass;
        mMethod = method;

        mIsStatic = Modifier.isStatic(mMethod.getModifiers());
    }

    public T invoke(Object... receiverOrArgs) {
        try {
            return invokeWithException(receiverOrArgs);
        } catch (Throwable e) {
            Log.e("ReflectMethod", "invoke error: " + e.getMessage());
        }
        return null;
    }

    public T invokeWithException(Object... receiverOrArgs) throws Throwable {
        Object receiver = null;
        Object[] args = null;
        if (mIsStatic) {
            args = receiverOrArgs;
        } else {
            receiver = receiverOrArgs[0];
            if (receiverOrArgs.length > 1) {
                args = Arrays.copyOfRange(receiverOrArgs, 1, receiverOrArgs.length);
            }
        }
        try {
            return (T) mMethod.invoke(receiver, args);
        } catch (InvocationTargetException e) {
            if (e.getCause() != null) {
                throw e.getCause();
            } else {
                throw e;
            }
        }
    }

    public int argsNum() {
        return mMethod.getParameterTypes().length;
    }

    public boolean isStatic() {
        return mIsStatic;
    }

    @Override
    public String toString() {
        return "ReflectMethod{" +
                "mClass=" + mClass +
                ", mMethod=" + mMethod +
                ", mIsStatic=" + mIsStatic +
                '}';
    }
}
