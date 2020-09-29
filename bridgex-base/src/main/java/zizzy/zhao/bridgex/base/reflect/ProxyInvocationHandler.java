package zizzy.zhao.bridgex.base.reflect;

import android.text.TextUtils;
import android.util.Log;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public abstract class ProxyInvocationHandler<T> implements InvocationHandler {
    private static final String TAG = ProxyInvocationHandler.class.getSimpleName();

    private T mOldObject;
    private Map<String, MethodProxy> mMethodProxyMap = new HashMap<>();

    protected abstract void bindMethodProxies();

    protected void setOldObject(T oldObject) {
        mOldObject = oldObject;
    }

    protected T getOldObject() {
        return mOldObject;
    }

    protected T newProxyInstance(T oldObj) {
        mOldObject = oldObj;

        Class clazz = oldObj.getClass();
        Class<?>[] interfaces = ClassUtil.getAllInterfaces(clazz);

        return (T) Proxy.newProxyInstance(clazz.getClassLoader(), interfaces, this);
    }

    protected Object newProxyInstance(Class clazz) {
        Class<?>[] interfaces = ClassUtil.getAllInterfaces(clazz);
        return Proxy.newProxyInstance(clazz.getClassLoader(), interfaces, this);
    }

    private MethodProxy getMethodProxy(String methodName) {
        if (mMethodProxyMap.containsKey(methodName)) {
            return mMethodProxyMap.get(methodName);
        } else {
            return null;
        }
    }

    protected void addMethodProxy(MethodProxy methodProxy) {
        if ((methodProxy != null) && !TextUtils.isEmpty(methodProxy.getMethodName())) {
            if (!mMethodProxyMap.containsKey(methodProxy.getMethodName())) {
                mMethodProxyMap.put(methodProxy.getMethodName(), methodProxy);
            }
        }
    }

    @Override
    public Object invoke(Object proxy, Method method, Object... args) throws Throwable {
        MethodProxy methodProxy = getMethodProxy(method.getName());

        try {
            Object res = null;
            if (methodProxy.beforeInvoke(mOldObject, method, args)) {
                res = methodProxy.invoke(mOldObject, method, args);
            }
            res = methodProxy.afterInvoke(mOldObject, method, args, res);

            printLog(res, method, args);
            return res;
        } catch (InvocationTargetException e) {
            Throwable cause = e.getTargetException();
            if (MethodUtil.isMethodDeclaredThrowable(method, cause)) {
                throw cause;
            } else if (cause != null) {
                RuntimeException runtimeException = !TextUtils.isEmpty(cause.getMessage())
                        ? new RuntimeException(cause.getMessage())
                        : new RuntimeException();
                runtimeException.initCause(cause);
                throw runtimeException;
            } else {
                RuntimeException runtimeException = !TextUtils.isEmpty(e.getMessage())
                        ? new RuntimeException(e.getMessage())
                        : new RuntimeException();
                runtimeException.initCause(e);
                throw runtimeException;
            }
        } catch (IllegalArgumentException e) {
            try {
                StringBuilder sb = new StringBuilder();
                sb.append("===>>> {");
                sb.append(" method[").append(method.toString()).append("]");

                if (args != null) {
                    sb.append(" | args[").append(Arrays.toString(args)).append("]");
                } else {
                    sb.append(" | args[").append("NULL").append("]");
                }
                sb.append("}");

                String message = e.getMessage() + sb.toString();
                throw new IllegalArgumentException(message, e);
            } catch (Throwable e1) {
                throw e;
            }
        } catch (Throwable e) {
            if (MethodUtil.isMethodDeclaredThrowable(method, e)) {
                throw e;
            } else {
                RuntimeException runtimeException = !TextUtils.isEmpty(e.getMessage())
                        ? new RuntimeException(e.getMessage())
                        : new RuntimeException();
                runtimeException.initCause(e);
                throw runtimeException;
            }
        }
    }

    private void printLog(Object res, Method method, Object... args) {
        StringBuilder sb = new StringBuilder();
        sb.append("===>>> {");
        sb.append(" method[").append(method.toString()).append("]");

        if (args != null) {
            sb.append(" | args[");
            int i = 0;
            for (Object arg : args) {
                if (arg == null) {
                    sb.append("NULL");
                } else {
                    if (i > 1) {
                        sb.append(",");
                    }
                    sb.append(arg.toString());
                }
                ++i;
            }
            sb.append("]");
        } else {
            sb.append(" | args[NULL]");
        }

        if (res == null) {
            sb.append(" | res[NULL]");
        } else {
            sb.append(" | res[").append(res.toString()).append("]");
        }

        sb.append("}");

        Log.d(TAG, sb.toString());
    }
}
