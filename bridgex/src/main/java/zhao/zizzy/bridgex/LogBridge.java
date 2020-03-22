package zhao.zizzy.bridgex;

import android.util.Log;

public class LogBridge {

    private static final String TAG = LogBridge.class.getSimpleName();
    private static LogBridge instance = new LogBridge();
    private ILogger logger;

    private LogBridge() {
    }

    public static void inject(ILogger logger) {
        instance.logger = logger;
    }

    public static void log(Object source) {
        if (instance.logger == null) {
            Log.d(TAG, source.toString(), null);
            return;
        }
        instance.logger.log(source);
    }

    public static void log(Object... args) {
        if (instance.logger == null) {
            StringBuilder builder = new StringBuilder();
            boolean isFirst = true;
            for (Object arg : args) {
                if (isFirst) {
                    isFirst = false;
                    builder.append(arg);
                } else {
                    builder.append(", " + arg);
                }
            }
            Log.d(TAG, builder.toString());
            return;
        }
        instance.logger.log(args);
    }

    public static void log(String tag, Object source) {
        if (instance.logger == null) {
            Log.d(tag, source.toString());
            return;
        }
        instance.logger.log(tag, source);
    }

    public interface ILogger {

        void log(Object source);

        void log(Object... args);

        void log(String tag, Object source);
    }
}
