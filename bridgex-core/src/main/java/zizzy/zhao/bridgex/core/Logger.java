package zizzy.zhao.bridgex.core;

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

import android.os.Build;
import android.os.Bundle;
import android.os.DeadSystemException;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.PrintWriter;
import java.io.Writer;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Default logger that logs to android.util.Log.
 */
public class Logger {
    public static final String TAG = "--bridgex--";

    private final String tag;
    private final int logLevel;
    private final AtomicInteger atomI;

    private static class Holder {
        private volatile static Logger DEFAULT_LOGGER = new Logger(TAG);
    }

    public Logger(String tag) {
        this.tag = tag;
        this.logLevel = Log.INFO;
        this.atomI = new AtomicInteger(0);
    }

    /**
     * Returns the global {@link Logger}.
     */
    private static Logger getLogger() {
        return Holder.DEFAULT_LOGGER;
    }

    private boolean canLog(int level) {
        return logLevel <= level || Log.isLoggable(tag, level);
    }

    public void logV(Object source) {
        if (canLog(Log.VERBOSE)) {
            atomI.incrementAndGet();
            println(source, Log.VERBOSE);
        }
    }

    public void logD(Object source) {
        if (canLog(Log.DEBUG)) {
            atomI.incrementAndGet();
            println(source, Log.DEBUG);
        }
    }

    public void logI(String source) {
        if (canLog(Log.INFO)) {
            atomI.incrementAndGet();
            println(source, Log.INFO);
        }
    }

    public void logW(String source) {
        if (canLog(Log.WARN)) {
            atomI.incrementAndGet();
            println(source, Log.WARN);
        }
    }

    public void logE(String source) {
        if (canLog(Log.ERROR)) {
            atomI.incrementAndGet();
            println(source, Log.ERROR);
        }
    }

    public void logE(String source, Throwable th) {
        if (canLog(Log.ERROR)) {
            Log.e(tag, source, th);
        }
    }

    public static void v(String source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logV(source);
    }

    public static void d(String source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logD(source);
    }

    public static void i(String source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logI(source);
    }

    public static void w(String source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logW(source);
    }

    public static void e(String source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logE(source);
    }

    public static void e(String source, Throwable th) {
        getLogger().atomI.incrementAndGet();
        getLogger().logE(source, th);
    }

    public static void log(Object source) {
        getLogger().atomI.incrementAndGet();
        getLogger().logD(source);
    }

    public static void log(int source) {
        getLogger().atomI.incrementAndGet();
        d(String.valueOf(source));
    }

    public static void log(long source) {
        getLogger().atomI.incrementAndGet();
        d(String.valueOf(source));
    }

    public static void log(float source) {
        getLogger().atomI.incrementAndGet();
        d(String.valueOf(source));
    }

    public static void log(double source) {
        getLogger().atomI.incrementAndGet();
        d(String.valueOf(source));
    }

    public static void log(boolean source) {
        getLogger().atomI.incrementAndGet();
        d(String.valueOf(source));
    }

    public static void printlnF(String format, Object... args) {
        getLogger().atomI.incrementAndGet();
        getLogger().println(String.format(Locale.US, format, args), Log.DEBUG);
    }

    private void println(Object source, int priority) {
        if (!canLog(priority)) {
            return;
        }

        synchronized (Holder.DEFAULT_LOGGER) {
            StringBuilder builder = new StringBuilder();

//            // check json
//            WeakReference wr = null;
//            try {
//                wr = new WeakReference<>(new JSONObject(source.toString()));
//            } catch (Throwable th1) {
//                try {
//                    wr = new WeakReference<>(new JSONArray(source.toString()));
//                } catch (Throwable th2) {
//                }
//            }
//
//            if (wr != null) {
//                source = formatJson(formatJsonBody(source));
//            } else if (source instanceof Bundle) { // check bundle
//                source = formatBundle((Bundle) source);
//            }

            if (source instanceof JSONObject
                    || source instanceof JSONArray) {
                source = formatJson(formatJsonBody(source));
            } else if (source instanceof Bundle) {
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

            int currentIndex = atomI.incrementAndGet();
            StackTraceElement[] stacks = new Throwable().fillInStackTrace().getStackTrace();
            StackTraceElement element = stacks[currentIndex];
            String fileName = element.getFileName();
            String className = element.getClassName();
            String methodClass = element.getMethodName();
            int lineNumber = element.getLineNumber();

            if (lineNumber != -2) {
                builder.append(String.format("--- [%s:%s] %s.%s %s", fileName, lineNumber, className,
                        methodClass, getFormatLog(source)));
            } else {
                builder.append(String.format("--- [%s] %s.%s %s", fileName, className,
                        methodClass, getFormatLog(source)));
            }

            printlns(priority, tag, builder.toString(), null);

            atomI.getAndSet(0);
        }
    }

    private String formatBundle(Bundle bundle) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n").append(getSplitter(87));
        for (String key : bundle.keySet()) {
            sb.append(formatString("\n| %-40s | %-40s |", key, bundle.get(key)));
            sb.append("\n").append(getSplitter(87));
        }
        return sb.toString();
    }

    private String formatString(String format, Object... args) {
        return String.format(Locale.US, format, args);
    }

    private String getFormatLog(Object o) {
        return o == null ? String.format("---> <CALL>") : String.format("---> %s", o);
    }

    private String formatJsonBody(Object source) {
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

    private String getSplitter(int length) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < length; i++) {
            builder.append("-");
        }
        return builder.toString();
    }

    private String formatJson(Object source) {
        StringBuilder builder = new StringBuilder();
        builder.append("\n");
        builder.append(getSplitter(100));
        builder.append("\n");
        builder.append(source);
        builder.append("\n");
        builder.append(getSplitter(100));
        return builder.toString();
    }

    private Object getJsonObjFromStr(Object test) {
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

    private int printlns(int priority, String tag, String msg, Throwable tr) {
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
        public final static int LOGGER_ENTRY_MAX_PAYLOAD = 4000;
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
}
