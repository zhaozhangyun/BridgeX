package zizzy.zhao.bridgex.hook;

import android.content.Context;
import android.util.Log;

import zizzy.zhao.bridgex.base.reflect.base.ReflectClass;
import zizzy.zhao.bridgex.base.reflect.base.ReflectConstructor;
import zizzy.zhao.bridgex.base.reflect.base.ReflectMethod;

public class XCMethodHookDelegate {
    private static final String TAG = "XCMethodHookDelegate";

    private XCMethodHookDelegate() {
    }

    public static void install(String className, Context context) {
        try {
            ReflectClass sClass = ReflectClass.load(className);
            ReflectConstructor constructor = sClass.getDefaultConstructor();
            Log.i(TAG, "The default constructor is: " + constructor);
            ReflectMethod install = sClass.getDeclaredMethod(
                    "install",
                    Context.class
            );
            install.invoke(constructor.newInstance(), context);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
