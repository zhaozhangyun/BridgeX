package zizzy.zhao.bridgex.base.reflect;

public abstract class ProxyHook<T> extends ProxyInvocationHandler<T> implements Hook {

    @Override
    public void install() {
        bindMethodProxies();
    }
}
