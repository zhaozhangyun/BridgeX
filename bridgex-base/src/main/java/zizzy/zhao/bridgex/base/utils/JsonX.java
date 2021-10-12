package zizzy.zhao.bridgex.base.utils;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.ref.WeakReference;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

public class JsonX {

    private JSONObject json;

    private JsonX(Builder builder) {
        try {
            json = new JSONObject(builder.weakJson.get().toString());
        } catch (Throwable th) {
            // Maybe gc...
            json = new JSONObject();
        }
    }

    public static Builder toBuilder() {
        return new Builder();
    }

    public static Builder toBuilder(JSONObject data) {
        return new Builder().on(new WeakReference<>(data));
    }

    public static Builder toBuilder(String data) throws JsonXException {
        return new Builder().on(data);
    }

    public static Builder toBuilder(Map copyFrom) throws JsonXException {
        return new Builder().on(copyFrom);
    }

    public static Builder toBuilder(Object data) throws JsonXException {
        return toBuilder(data.toString());
    }

    public static Builder toBuilder(InputStream data) throws JsonXException {
        return new Builder().on(data);
    }

    public static Builder toBuilder(File file) throws JsonXException {
        return new Builder().on(file);
    }

    public static Map<String, Object> toMap(JSONObject jo) {
        Iterator<String> iterator = jo.keys();
        Map<String, Object> valueMap = new LinkedHashMap<>();
        while (iterator.hasNext()) {
            String key = iterator.next();
            Object value = jo.opt(key);
            valueMap.put(key, value);
        }
        return valueMap;
    }

    @Override
    public String toString() {
        return out().toString();
    }

    public JSONObject out() {
        return json;
    }

    public static class Builder {

        private WeakReference<JSONObject> weakJson;

        private Builder() {
            weakJson = new WeakReference<>(new JSONObject());
        }

        private Builder on(WeakReference<JSONObject> json) {
            if (json == null || json.get() == null) {
                throw new NullPointerException("Oops!!! json object on a null object reference.");
            }
            this.weakJson = json;
            return this;
        }

        private Builder on(String json) throws JsonXException {
            try {
                return on(new WeakReference<>(new JSONObject(json)));
            } catch (Throwable th) {
                throw new JsonXException(th);
            }
        }

        private Builder on(Map copyFrom) throws JsonXException {
            try {
                return on(new WeakReference<>(new JSONObject(copyFrom)));
            } catch (Throwable th) {
                throw new JsonXException(th);
            }
        }

        private Builder on(InputStream toBuilder) throws JsonXException {
            return on(readStream(toBuilder));
        }

        private Builder on(File file) throws JsonXException {
            return on(readFile(file));
        }

        private String readStream(InputStream is) throws JsonXException {
            BufferedReader br = null;
            try {
                StringBuilder builder = new StringBuilder();
                br = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
                String line;
                while ((line = br.readLine()) != null) {
                    builder.append(line);
                }
                return builder.toString();
            } catch (Throwable th) {
                throw new JsonXException(th);
            } finally {
                if (br != null) {
                    try {
                        br.close();
                    } catch (IOException e) {
                    }
                }
            }
        }

        private String readFile(File file) throws JsonXException {
            try {
                return readStream(new FileInputStream(file));
            } catch (Throwable th) {
                throw new JsonXException(th);
            }
        }

        public Builder put(String name, Object value) {
            try {
                this.weakJson.get().putOpt(name, value);
            } catch (Throwable th) {
                th.printStackTrace();
            }
            return this;
        }

        public JsonX build() {
            return new JsonX(this);
        }
    }

    public static class JsonXException extends Exception {

        public JsonXException(String message) {
            super(message);
        }

        public JsonXException(String message, Throwable th) {
            super(message, th);
        }

        public JsonXException(Throwable th) {
            super(th);
        }
    }
}
