package zizzy.zhao.bridgex.base.utils;

import android.util.Log;

import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Util {

    private static final String TAG = "Util";

    public static Class[] getMethodArgs(String paramSig, ClassLoader classLoader) {
        int index = 0;
        List<Class> paramsArray = new ArrayList<>();
        while (index < paramSig.length()) {
            switch (paramSig.charAt(index)) {
                case 'B': // byte
                    paramsArray.add(byte.class);
                    break;
                case 'C': // char
                    paramsArray.add(char.class);
                    break;
                case 'D': // double
                    paramsArray.add(double.class);
                    break;
                case 'F': // float
                    paramsArray.add(float.class);
                    break;
                case 'I': // int
                    paramsArray.add(int.class);
                    break;
                case 'J': // long
                    paramsArray.add(long.class);
                    break;
                case 'S': // short
                    paramsArray.add(short.class);
                    break;
                case 'Z': // boolean
                    paramsArray.add(boolean.class);
                    break;
                case 'L':
                    try {
                        String objectClass = getObjectClass(index, paramSig);

                        if (classLoader != null) {
                            paramsArray.add(Class.forName(objectClass, true, classLoader));
                        } else {
                            paramsArray.add(Class.forName(objectClass));
                        }

                        index += objectClass.length() + 1;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case '[':
                    try {
                        String arrayClass = getArrayClass(index, paramSig);

                        if (classLoader != null) {
                            paramsArray.add(Class.forName(arrayClass, true, classLoader));
                        } else {
                            paramsArray.add(Class.forName(arrayClass));
                        }

                        index += arrayClass.length() - 1;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
            }
            index++;
        }

        Class[] params = new Class[paramsArray.size()];
        for (int i = 0; i < paramsArray.size(); i++) {
            params[i] = paramsArray.get(i);
        }

        Log.d(TAG, "The params is " + Arrays.toString(params));

        return params;
    }

    public static Member getMethod(String className, String methodName, String paramSig,
                                   ClassLoader classLoader) {
        if (className.isEmpty() || methodName.isEmpty()) {
            return null;
        }

        Class[] params = getMethodArgs(paramSig, classLoader);

        Member method = null;
        try {
            if (classLoader != null) {
                if ("<init>".equals(methodName)) {
                    method = Class.forName(className, true, classLoader).getDeclaredConstructor(params);
                } else {
                    method = Class.forName(className, true, classLoader).getDeclaredMethod(methodName, params);
                }
            } else {
                if ("<init>".equals(methodName)) {
                    method = Class.forName(className).getDeclaredConstructor(params);
                } else {
                    method = Class.forName(className).getDeclaredMethod(methodName, params);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return method;
    }

    private static String getObjectClass(int index, String paramSig) {
        String objectClass = null;

        String subParam = paramSig.substring(index + 1);
        objectClass = subParam.split(";")[0].replace('/', '.');

        return objectClass;
    }

    private static String getArrayClass(int index, String paramSig) {
        StringBuilder arrayClassBuilder = new StringBuilder();

        while (paramSig.charAt(index) == '[') {
            index++;
            arrayClassBuilder.append('[');
        }

        if (paramSig.charAt(index) == 'L') {
            String subParam = paramSig.substring(index);
            arrayClassBuilder.append(subParam.split(";")[0].replace('/', '.'));
            arrayClassBuilder.append(";");
        } else {
            arrayClassBuilder.append(paramSig.charAt(index));
        }

        return arrayClassBuilder.toString();
    }
}
