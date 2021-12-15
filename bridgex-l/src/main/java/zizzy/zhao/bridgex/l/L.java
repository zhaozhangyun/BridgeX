package zizzy.zhao.bridgex.l;

// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.DeadSystemException;
import android.text.TextUtils;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.lang.ref.WeakReference;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Locale;

/**
 * Default logger that logs to android.util.Log.
 */
public class L {

    private static final String TAG = "--bridgex--";
    private static Config sConfig;
    private static Object lock = new Object[0];

    public static void setConfiguration(Config config) {
        sConfig = config;
    }

    public static void attach(Context context) {
        synchronized (lock) {
            InputStream is = null;
            try {
                is = context.getResources().getAssets().open("logger_conf.json");
                int size = is.available();
                byte[] buffer = new byte[size];
                is.read(buffer);
                JSONObject jo = new JSONObject(new String(buffer));
                String tag = jo.optString("default_tag");
                int logLevel = jo.optInt("log_level");
                sConfig = new Config.Builder(TextUtils.isEmpty(tag) ? TAG : tag)
                        .logLevel(logLevel == 0 ? Log.INFO : logLevel)
                        .showShortClass(jo.optBoolean("show_short_class"))
                        .build();
            } catch (Throwable th) {
                Log.e(TAG, "Error to parse logger_conf.json with " + th);
            } finally {
                if (is != null) {
                    try {
                        is.close();
                    } catch (IOException e) {
                    }
                }
            }
        }
    }

    public static void v(String source) {
        if (canLog(Log.VERBOSE)) {
            println(source, Log.VERBOSE);
        }
    }

    public static void d(Object source) {
        if (canLog(Log.DEBUG)) {
            println(source, Log.DEBUG);
        }
    }

    public static void i(String source) {
        if (canLog(Log.INFO)) {
            println(source, Log.INFO);
        }
    }

    public static void w(String source) {
        if (canLog(Log.WARN)) {
            println(source, Log.WARN);
        }
    }

    public static void e(String source) {
        if (canLog(Log.ERROR)) {
            println(source, Log.ERROR);
        }
    }

    public static void e(String source, Throwable th) {
        if (canLog(Log.ERROR)) {
            println(source + System.getProperty("line.separator") + th, Log.ERROR);
        }
    }

    public static void logs(Object... source) {
        if (canLog(Log.DEBUG)) {
            println(processBody(source), Log.DEBUG);
        }
    }

    public static void printlnF(String format, Object... args) {
        if (canLog(Log.DEBUG)) {
            println(String.format(Locale.US, format, args), Log.DEBUG);
        }
    }

    private static boolean canLog(int level) {
        return sConfig.logLevel <= level || Log.isLoggable(sConfig.tag, level);
    }

    private static String processBody(Object... objArr) {
        String str = null;
        if (objArr != null) {
            if (objArr.length == 1 && objArr[0] != null) {
                str = objArr[0].toString();
            } else {
                StringBuilder sb = new StringBuilder();
                sb.append(System.getProperty("line.separator"))
                        .append(getSplitter(87));
                for (int i = 0; i < objArr.length; i++) {
                    sb.append(System.getProperty("line.separator"))
                            .append("args")
                            .append("[")
                            .append(i)
                            .append("]")
                            .append(":= ")
                            .append(objArr[i]);
                }
                sb.append(System.getProperty("line.separator"))
                        .append(getSplitter(87));
                str = sb.toString();
            }
        }
        return TextUtils.isEmpty(str) ? "(no content)" : str;
    }

    private static void println(Object source, int priority) {
        if (!canLog(priority)) {
            return;
        }

        if (source == null) {
            source = "(no content)";
        }

        synchronized (lock) {
            StringBuilder sb = new StringBuilder();

            // check json
            WeakReference wr = null;
            try {
                wr = new WeakReference<>(new JSONObject(source.toString()));
            } catch (Throwable th1) {
                try {
                    wr = new WeakReference<>(new JSONArray(source.toString()));
                } catch (Throwable th2) {
                }
            }
            if (wr != null) {
                source = formatJson(formatJsonBody(source));
            } else if (source instanceof Bundle) { // check bundle
                source = formatBundle((Bundle) source);
            } else if (source instanceof Object[]) {
                source = Arrays.toString((Object[]) source);
            } else if (source instanceof int[]) {
                source = Arrays.toString((int[]) source);
            } else if (source instanceof long[]) {
                source = Arrays.toString((long[]) source);
            } else if (source instanceof float[]) {
                source = Arrays.toString((float[]) source);
            } else if (source instanceof double[]) {
                source = Arrays.toString((double[]) source);
            } else if (source instanceof boolean[]) {
                source = Arrays.toString((boolean[]) source);
            } else if (source instanceof byte[]) {
                source = Arrays.toString((byte[]) source);
            }

            StackTraceElement[] stacks = new Throwable().fillInStackTrace().getStackTrace();
            StackTraceElement element = stacks[2];
            String fileName = element.getFileName();
            String className = element.getClassName();
            String methodClass = element.getMethodName();
            int lineNumber = element.getLineNumber();

            if (sConfig.showShortClass) {
                if (lineNumber != -2) {
                    sb.append(String.format("--- %s : %s.%s %s", lineNumber,
                            className.substring(className.lastIndexOf(".") + 1),
                            methodClass, getFormatLog(source)));
                } else {
                    sb.append(String.format("--- [%s] %s.%s %s", fileName,
                            className.substring(className.lastIndexOf(".") + 1),
                            methodClass, getFormatLog(source)));
                }
            } else {
                if (lineNumber != -2) {
                    sb.append(String.format("--- [%s:%s] %s.%s %s", fileName, lineNumber,
                            className, methodClass, getFormatLog(source)));
                } else {
                    sb.append(String.format("--- [%s] %s.%s %s", fileName, className,
                            methodClass, getFormatLog(source)));
                }
            }

            printlns(priority, sConfig.tag, sb.toString(), null);
        }
    }

    private static String formatBundle(Bundle bundle) {
        StringBuilder sb = new StringBuilder();
        sb.append(System.getProperty("line.separator")).append(getSplitter(87));
        for (String key : bundle.keySet()) {
            sb.append(formatString("\n| %-40s | %-40s |", key, bundle.get(key)));
            sb.append(System.getProperty("line.separator")).append(getSplitter(87));
        }
        return sb.toString();
    }

    private static String formatString(String format, Object... args) {
        return String.format(Locale.US, format, args);
    }

    private static String getFormatLog(Object o) {
        return o == null ? String.format("---> <CALL>") : String.format("---> %s", o);
    }

    private static String formatJsonBody(Object source) {
        Object o = getJsonObjFromStr(source);
        if (o != null) {
            try {
                if (o instanceof JSONObject) {
                    return ((JSONObject) o).toString(2);
                } else if (o instanceof JSONArray) {
                    return ((JSONArray) o).toString(2);
                } else {
                    return source.toString();
                }
            } catch (JSONException e) {
                return source.toString();
            }
        } else {
            return source.toString();
        }
    }

    private static String getSplitter(int length) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append("-");
        }
        return sb.toString();
    }

    private static String formatJson(Object source) {
        StringBuilder sb = new StringBuilder();
        sb.append(System.getProperty("line.separator"));
        sb.append(getSplitter(100));
        sb.append(System.getProperty("line.separator"));
        sb.append(source);
        sb.append(System.getProperty("line.separator"));
        sb.append(getSplitter(100));
        return sb.toString();
    }

    private static Object getJsonObjFromStr(Object test) {
        Object o = null;
        try {
            o = new JSONObject(test.toString());
        } catch (JSONException ex) {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    o = new JSONArray(test);
                }
            } catch (JSONException ex1) {
                return null;
            }
        }
        return o;
    }

    private static int printlns(int priority, String tag, String msg, Throwable tr) {
        ImmediateLogWriter logWriter = new ImmediateLogWriter(priority, tag);
        // Acceptable buffer size. Get the native buffer size, subtract two zero terminators,
        // and the length of the tag.
        // Note: we implicitly accept possible truncation for Modified-UTF8 differences. It
        //       is too expensive to compute that ahead of time.
        int bufferSize = PreloadHolder.LOGGER_ENTRY_MAX_PAYLOAD    // Base.
                - 2                                                // Two terminators.
                - (tag != null ? tag.length() : 0)                 // Tag length.
                - 32;                                              // Some slack.
        // At least assume you can print *some* characters (tag is not too large).
        bufferSize = Math.max(bufferSize, 100);

        LineBreakBufferedWriter lbbw = new LineBreakBufferedWriter(logWriter, bufferSize);

        lbbw.println(msg);

        if (tr != null) {
            // This is to reduce the amount of log spew that apps do in the non-error
            // condition of the network being unavailable.
            Throwable t = tr;
            while (t != null) {
                if (t instanceof UnknownHostException) {
                    break;
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    if (t instanceof DeadSystemException) {
                        lbbw.println("DeadSystemException: The system died; "
                                + "earlier logs will point to the root cause");
                        break;
                    }
                }
                t = t.getCause();
            }
            if (t == null) {
                tr.printStackTrace(lbbw);
            }
        }

        lbbw.flush();

        return logWriter.getWritten();
    }

    /**
     * PreloadHelper class. Caches the LOGGER_ENTRY_MAX_PAYLOAD value to avoid
     * a JNI call during logging.
     */
    static class PreloadHolder {
        private final static int LOGGER_ENTRY_MAX_PAYLOAD = 4000;
    }

    /**
     * Helper class to write to the logcat. Different from LogWriter, this writes
     * the whole given buffer and does not break along newlines.
     */
    static class ImmediateLogWriter extends Writer {

        private int priority;
        private String tag;
        private int written = 0;

        /**
         * Create a writer that immediately writes to the log, using the given
         * parameters.
         */
        ImmediateLogWriter(int priority, String tag) {
            this.priority = priority;
            this.tag = tag;
        }

        int getWritten() {
            return written;
        }

        @Override
        public void write(char[] cbuf, int off, int len) {
            // Note: using String here has a bit of overhead as a Java object is created,
            //       but using the char[] directly is not easier, as it needs to be translated
            //       to a C char[] for logging.
            written += Log.println(priority, tag, new String(cbuf, off, len));
        }

        @Override
        public void flush() {
            // Ignored.
        }

        @Override
        public void close() {
            // Ignored.
        }
    }

    /**
     * A writer that breaks up its output into chunks before writing to its out writer,
     * and which is linebreak aware, i.e., chunks will created along line breaks, if
     * possible.
     * <p>
     * Note: this class is not thread-safe.
     */
    static class LineBreakBufferedWriter extends PrintWriter {

        /**
         * The chunk size (=maximum buffer size) to use for this writer.
         */
        private final int bufferSize;
        /**
         * The line separator for println().
         */
        private final String lineSeparator;
        /**
         * A buffer to collect data until the buffer size is reached.
         * <p>
         * Note: we manage a char[] ourselves to avoid an allocation when printing to the
         * out writer. Otherwise a StringBuilder would have been simpler to use.
         */
        private char[] buffer;
        /**
         * The index of the first free element in the buffer.
         */
        private int bufferIndex;
        /**
         * Index of the last newline character discovered in the buffer. The writer will try
         * to split there.
         */
        private int lastNewline = -1;

        /**
         * Create a new linebreak-aware buffered writer with the given output and buffer
         * size. The initial capacity will be a default value.
         *
         * @param out        The writer to write to.
         * @param bufferSize The maximum buffer size.
         */
        LineBreakBufferedWriter(Writer out, int bufferSize) {
            this(out, bufferSize, 16);  // 16 is the default size of a StringBuilder buffer.
        }

        /**
         * Create a new linebreak-aware buffered writer with the given output, buffer
         * size and initial capacity.
         *
         * @param out             The writer to write to.
         * @param bufferSize      The maximum buffer size.
         * @param initialCapacity The initial capacity of the internal buffer.
         */
        LineBreakBufferedWriter(Writer out, int bufferSize, int initialCapacity) {
            super(out);
            this.buffer = new char[Math.min(initialCapacity, bufferSize)];
            this.bufferIndex = 0;
            this.bufferSize = bufferSize;
            this.lineSeparator = System.getProperty("line.separator");
        }

        /**
         * Flush the current buffer. This will ignore line breaks.
         */
        @Override
        public void flush() {
            writeBuffer(bufferIndex);
            bufferIndex = 0;
            super.flush();
        }

        @Override
        public void write(int c) {
            if (bufferIndex < buffer.length) {
                buffer[bufferIndex] = (char) c;
                bufferIndex++;
                if ((char) c == '\n') {
                    lastNewline = bufferIndex;
                }
            } else {
                // This should be an uncommon case, we mostly expect char[] and String. So
                // let the chunking be handled by the char[] case.
                write(new char[]{(char) c}, 0, 1);
            }
        }

        @Override
        public void println() {
            write(lineSeparator);
        }

        @Override
        public void write(char[] buf, int off, int len) {
            while (bufferIndex + len > bufferSize) {
                // Find the next newline in the buffer, see if that's below the limit.
                // Repeat.
                int nextNewLine = -1;
                int maxLength = bufferSize - bufferIndex;
                for (int i = 0; i < maxLength; i++) {
                    if (buf[off + i] == '\n') {
                        if (bufferIndex + i < bufferSize) {
                            nextNewLine = i;
                        } else {
                            break;
                        }
                    }
                }

                if (nextNewLine != -1) {
                    // We can add some more data.
                    appendToBuffer(buf, off, nextNewLine);
                    writeBuffer(bufferIndex);
                    bufferIndex = 0;
                    lastNewline = -1;
                    off += nextNewLine + 1;
                    len -= nextNewLine + 1;
                } else if (lastNewline != -1) {
                    // Use the last newline.
                    writeBuffer(lastNewline);
                    removeFromBuffer(lastNewline + 1);
                    lastNewline = -1;
                } else {
                    // OK, there was no newline, break at a full buffer.
                    int rest = bufferSize - bufferIndex;
                    appendToBuffer(buf, off, rest);
                    writeBuffer(bufferIndex);
                    bufferIndex = 0;
                    off += rest;
                    len -= rest;
                }
            }

            // Add to the buffer, this will fit.
            if (len > 0) {
                // Add the chars, find the last newline.
                appendToBuffer(buf, off, len);
                for (int i = len - 1; i >= 0; i--) {
                    if (buf[off + i] == '\n') {
                        lastNewline = bufferIndex - len + i;
                        break;
                    }
                }
            }
        }

        @Override
        public void write(String s, int off, int len) {
            while (bufferIndex + len > bufferSize) {
                // Find the next newline in the buffer, see if that's below the limit.
                // Repeat.
                int nextNewLine = -1;
                int maxLength = bufferSize - bufferIndex;
                for (int i = 0; i < maxLength; i++) {
                    if (s.charAt(off + i) == '\n') {
                        if (bufferIndex + i < bufferSize) {
                            nextNewLine = i;
                        } else {
                            break;
                        }
                    }
                }

                if (nextNewLine != -1) {
                    // We can add some more data.
                    appendToBuffer(s, off, nextNewLine);
                    writeBuffer(bufferIndex);
                    bufferIndex = 0;
                    lastNewline = -1;
                    off += nextNewLine + 1;
                    len -= nextNewLine + 1;
                } else if (lastNewline != -1) {
                    // Use the last newline.
                    writeBuffer(lastNewline);
                    removeFromBuffer(lastNewline + 1);
                    lastNewline = -1;
                } else {
                    // OK, there was no newline, break at a full buffer.
                    int rest = bufferSize - bufferIndex;
                    appendToBuffer(s, off, rest);
                    writeBuffer(bufferIndex);
                    bufferIndex = 0;
                    off += rest;
                    len -= rest;
                }
            }

            // Add to the buffer, this will fit.
            if (len > 0) {
                // Add the chars, find the last newline.
                appendToBuffer(s, off, len);
                for (int i = len - 1; i >= 0; i--) {
                    if (s.charAt(off + i) == '\n') {
                        lastNewline = bufferIndex - len + i;
                        break;
                    }
                }
            }
        }

        /**
         * Append the characters to the buffer. This will potentially resize the buffer,
         * and move the index along.
         *
         * @param buf The char[] containing the data.
         * @param off The start index to copy from.
         * @param len The number of characters to copy.
         */
        private void appendToBuffer(char[] buf, int off, int len) {
            if (bufferIndex + len > buffer.length) {
                ensureCapacity(bufferIndex + len);
            }
            System.arraycopy(buf, off, buffer, bufferIndex, len);
            bufferIndex += len;
        }

        /**
         * Append the characters from the given string to the buffer. This will potentially
         * resize the buffer, and move the index along.
         *
         * @param s   The string supplying the characters.
         * @param off The start index to copy from.
         * @param len The number of characters to copy.
         */
        private void appendToBuffer(String s, int off, int len) {
            if (bufferIndex + len > buffer.length) {
                ensureCapacity(bufferIndex + len);
            }
            s.getChars(off, off + len, buffer, bufferIndex);
            bufferIndex += len;
        }

        /**
         * Resize the buffer. We use the usual double-the-size plus constant scheme for
         * amortized O(1) insert. Note: we expect small buffers, so this won't check for
         * overflow.
         *
         * @param capacity The size to be ensured.
         */
        private void ensureCapacity(int capacity) {
            int newSize = buffer.length * 2 + 2;
            if (newSize < capacity) {
                newSize = capacity;
            }
            buffer = Arrays.copyOf(buffer, newSize);
        }

        /**
         * Remove the characters up to (and excluding) index i from the buffer. This will
         * not resize the buffer, but will update bufferIndex.
         *
         * @param i The number of characters to remove from the front.
         */
        private void removeFromBuffer(int i) {
            int rest = bufferIndex - i;
            if (rest > 0) {
                System.arraycopy(buffer, bufferIndex - rest, buffer, 0, rest);
                bufferIndex = rest;
            } else {
                bufferIndex = 0;
            }
        }

        /**
         * Helper method, write the given part of the buffer, [start,length), to the output.
         *
         * @param length The number of characters to flush.
         */
        private void writeBuffer(int length) {
            if (length > 0) {
                super.write(buffer, 0, length);
            }
        }
    }

    public static class Config {

        private String tag;
        private int logLevel;
        private boolean showShortClass;

        private Config(Builder builder) {
            this.tag = builder.tag;
            this.logLevel = builder.logLevel;
            this.showShortClass = builder.showShortClass;
        }

        public static class Builder {

            private String tag;
            private int logLevel;
            private boolean showShortClass;

            public Builder(String tag) {
                this.tag = tag;
            }

            public Builder logLevel(int level) {
                this.logLevel = level;
                return this;
            }

            public Builder showShortClass(boolean enabled) {
                this.showShortClass = enabled;
                return this;
            }

            public Config build() {
                return new Config(this);
            }
        }
    }
}
