package zizzy.zhao.bridgex.hook;

import android.content.Context;
import android.util.Log;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;

public class XCMethodHookDelegate {
    private static final String TAG = "XCMethodHookDelegate";
    private ReflectClass sClass;
    private ReflectConstructor constructor;
    private ReflectMethod install;

    public void install(String className, Context context) throws Throwable {
        sClass = ReflectClass.load(className);
        constructor = sClass.getDefaultConstructor();
        Log.d(TAG, "The default constructor is: " + constructor);
        install = sClass.getDeclaredMethod(
                "install",
                Context.class
        );

        install.invoke(constructor.newInstance(), context);
    }
}
