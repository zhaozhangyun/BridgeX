package zizzy.zhao.bridgex.base.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class URLEncoding {

    private static final String ENCODING = "UTF-8";

    /**
     * URLEncoder编码
     */
    public static String toURLEncoded(String paramString) {
        if (paramString == null || paramString.equals("")) {
            return "";
        }
        try {
            String str = new String(paramString.getBytes(), ENCODING);
            str = URLEncoder.encode(str, ENCODING);
            return str;
        } catch (Exception localException) {
        }
        return "";
    }

    /**
     * URLDecoder解码
     */
    public static String toURLDecoded(String paramString) {
        if (paramString == null || paramString.equals("")) {
            return "";
        }
        try {
            String url = new String(paramString.getBytes(), ENCODING);
            url = URLDecoder.decode(url, ENCODING);
            return url;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return "";
    }
}