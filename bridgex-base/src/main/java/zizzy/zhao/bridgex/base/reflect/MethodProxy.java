package zizzy.zhao.bridgex.base.reflect;

import java.lang.reflect.Method;

public abstract class MethodProxy {
    private String mMethodName;

    public MethodProxy() {
    }

    protected void setMethodName(String methodName) {
        mMethodName = methodName;
    }

    public String getMethodName() {
        return mMethodName;
    }

    public boolean beforeInvoke(Object who, Method method, Object... args) {
        return true;
    }

    public Object invoke(Object who, Method method, Object... args) throws Throwable {
        return method.invoke(who, args);
    }

    public Object afterInvoke(Object who, Method method, Object[] args, Object result) {
        return result;
    }
}
