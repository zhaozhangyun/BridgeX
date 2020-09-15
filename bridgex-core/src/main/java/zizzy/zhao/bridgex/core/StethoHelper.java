package zizzy.zhao.bridgex.core;

import android.content.Context;
import android.util.Log;

import com.facebook.stetho.Stetho;
import com.facebook.stetho.urlconnection.ByteArrayRequestEntity;
import com.facebook.stetho.urlconnection.SimpleRequestEntity;
import com.facebook.stetho.urlconnection.StethoURLConnectionManager;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.util.Arrays;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.zip.GZIPInputStream;

public class StethoHelper {

    private static final String TAG = "StethoHelper";
    private static final String HEADER_ACCEPT_ENCODING = "Accept-Encoding";
    private static final String GZIP_ENCODING = "gzip";
    private static SimpleRequestEntity requestEntity = null;
    private static Map<String, StethoURLConnectionManager> stethoURLConnectionManagerCache = new ConcurrentHashMap<>();
    private static Object[] lock = new Object[1];

    public static void initializeStetho(Context context) {
        Stetho.initializeWithDefaults(context);
    }

    private static StethoURLConnectionManager getStethoURLConnectionManager(String friendlyName) {
        synchronized (lock) {
            if (!stethoURLConnectionManagerCache.containsKey(friendlyName)) {
                StethoURLConnectionManager manager = new StethoURLConnectionManager(friendlyName);
                if (manager != null) {
                    stethoURLConnectionManagerCache.put(friendlyName, manager);
                }
                return manager;
            } else {
                return stethoURLConnectionManagerCache.get(friendlyName);
            }
        }
    }

    public static InputStream interpretStethoURLResponseStream(String friendlyName,
                                                               InputStream responseStream) {
        StethoURLConnectionManager manager = getStethoURLConnectionManager(friendlyName);
        Log.d(TAG, "invoke interpretStethoURLResponseStream(): friendlyName=" + friendlyName);
        return manager.interpretResponseStream(responseStream);
    }

    public static void preConnect(HttpURLConnection connection) {
        preConnect(connection.getURL().toString().trim(), connection, false, null);
    }

    public static void preConnect(String friendlyName,
                                  HttpURLConnection connection,
                                  boolean needDecompression,
                                  byte[] requestBody) {
        if (needDecompression) {
            requestDecompression(connection);
        }

        if (requestBody != null) {
            requestEntity = new ByteArrayRequestEntity(requestBody);
        }
        StethoURLConnectionManager manager = getStethoURLConnectionManager(friendlyName);
        Log.d(TAG, "invoke preConnect(): friendlyName=" + friendlyName);
        manager.preConnect(connection, requestEntity);
    }

    public static void writeTo(OutputStream out) {
        if (requestEntity == null) {
            throw new IllegalStateException("Oops!!! You must invoke preConnect method first.");
        }

        try {
            requestEntity.writeTo(out);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void postConnect(HttpURLConnection connection) {
        postConnect(connection.getURL().toString().trim());
    }

    public static void postConnect(String friendlyName) {
        StethoURLConnectionManager manager = getStethoURLConnectionManager(friendlyName);
        Log.d(TAG, "invoke postConnect(): friendlyName=" + friendlyName);
        try {
            manager.postConnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void httpExchangeFailed(String friendlyName, IOException ex) {
        StethoURLConnectionManager manager = getStethoURLConnectionManager(friendlyName);
        manager.httpExchangeFailed(ex);
    }

    public static HttpResponse doFetch(String friendlyName,
                                       HttpURLConnection conn,
                                       InputStream rawStream) throws IOException {
        StethoURLConnectionManager manager = getStethoURLConnectionManager(friendlyName);
        try {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
//            InputStream rawStream = conn.getInputStream();
            try {
                // Let Stetho see the raw, possibly compressed stream.
                rawStream = manager.interpretResponseStream(rawStream);
                InputStream decompressedStream = applyDecompressionIfApplicable(conn, rawStream);
                if (decompressedStream != null) {
                    copy(decompressedStream, out, new byte[1024]);
                }
            } finally {
                if (rawStream != null) {
                    rawStream.close();
                }
            }
            return new HttpResponse(conn.getResponseCode(), out.toByteArray());
        } finally {
            conn.disconnect();
        }
    }

    private static void requestDecompression(HttpURLConnection conn) {
        conn.setRequestProperty(HEADER_ACCEPT_ENCODING, GZIP_ENCODING);
    }

    private static InputStream applyDecompressionIfApplicable(HttpURLConnection conn,
                                                              InputStream in) throws IOException {
        if (in != null && GZIP_ENCODING.equals(conn.getContentEncoding())) {
            return new GZIPInputStream(in);
        }
        return in;
    }

    private static void copy(InputStream in, OutputStream out, byte[] buf) throws IOException {
        if (in == null) {
            return;
        }
        int n;
        while ((n = in.read(buf)) != -1) {
            out.write(buf, 0, n);
        }
    }

    public static class HttpResponse {
        public final int statusCode;
        public final byte[] body;

        HttpResponse(int statusCode, byte[] body) {
            this.statusCode = statusCode;
            this.body = body;
        }

        @Override
        public String toString() {
            return "HttpResponse{" +
                    "statusCode=" + statusCode +
                    ", body=" + Arrays.toString(body) +
                    '}';
        }
    }
}
