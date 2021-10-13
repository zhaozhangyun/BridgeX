package zizzy.zhao.bridgex.base.utils;


import android.util.Log;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

public class StringUtil {

    private static final String TAG = "StringUtil";

    public static boolean isEmpty(CharSequence str) {
        return str == null || str.length() == 0;
    }

    public static String formatString(String format, Object... args) {
        return String.format(Locale.US, format, args);
    }

    public static void addString(Map<String, String> parameters, String key, String value) {
        if (isEmpty(value)) {
            return;
        }
        parameters.put(key, value);
    }

    public static <T> Map<String, T> mergeParameters(Map<String, T> target,
                                                     Map<String, Object> source,
                                                     String parameterName) {
        if (target == null) {
            return (Map<String, T>) source;
        }
        if (source == null) {
            return target;
        }
        Map<String, T> mergedParameters = new HashMap<>(target);
        for (Map.Entry<String, Object> parameterSourceEntry : source.entrySet()) {
            T oldValue = mergedParameters.put(parameterSourceEntry.getKey(),
                    (T) parameterSourceEntry.getValue());
            if (oldValue != null) {
                Log.w(TAG, formatString("Key %s with value %s from %s parameter was replaced by value %s",
                        parameterSourceEntry.getKey(),
                        oldValue,
                        parameterName,
                        parameterSourceEntry.getValue()));
            }
        }
        return mergedParameters;
    }

    public static String getExtendedString(Map<String, ?> parameters) {
        return getExtendedString(parameters, false);
    }

    public synchronized static String getExtendedString(Map<String, ?> parameters, boolean sorted) {
        StringBuilder builder = new StringBuilder();
        if (parameters != null) {
            builder.append("\n")
                    .append("Parameters ---------------------------------------------------------");
            if (sorted) {
                SortedMap<String, ?> sortedParameters = new TreeMap<>(parameters);
                for (Map.Entry<String, ?> entry : sortedParameters.entrySet()) {
                    String key = entry.getKey();
                    builder.append(formatString("\n\t%-32s %s", key, entry.getValue()));
                }
            } else {
                for (Map.Entry<String, ?> entry : parameters.entrySet()) {
                    String key = entry.getKey();
                    builder.append(formatString("\n\t%-32s %s", key, entry.getValue()));
                }
            }
            builder.append("\n")
                    .append("--------------------------------------------------------------------");
        }
        return builder.toString();
    }
}
