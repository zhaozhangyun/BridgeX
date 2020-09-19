package zizzy.zhao.bridgex.multidex;

import android.text.TextUtils;
import android.util.Log;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5 {

    /**
     * 默认的密码字符串组合，用来将字节转换成 16 进制表示的字符,apache校验下载的文件的正确性用的就是默认的这个组合
     */
    private static char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    private static MessageDigest messagedigest = null;

    static {
        try {
            messagedigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            Log.e("MD5", "MessageDigest error: ", e);
        }
    }

    /**
     * 生成字符串的md5校验值
     *
     * @param content 要生成的字符串
     * @return
     */
    public static String getMD5(String content) {
        return getMD5String(content.getBytes());
    }

    /**
     * 判断字符串的md5校验码是否与一个已知的md5码相匹配
     *
     * @param password  要校验的字符串
     * @param md5PwdStr 已知的md5校验码
     * @return
     */
    public static boolean checkPassword(String password, String md5PwdStr) {
        String s = getMD5(password);
        return s.equals(md5PwdStr);
    }

    public static String getFileMD5(File file) throws Exception {
        InputStream fis = new FileInputStream(file);
        return getFileStreamMD5(fis);
    }

    public static String getFileStreamMD5(InputStream is) throws Exception {
        byte[] buffer = new byte[1024];
        int numRead;
        while ((numRead = is.read(buffer)) > 0) {
            messagedigest.update(buffer, 0, numRead);
        }
        is.close();
        return bufferToHex(messagedigest.digest());
    }

    public static boolean compareToMd5(File filePath, InputStream is) {
        boolean result = false;

        String fileMd5 = null;
        if (filePath != null && filePath.exists()) {
            try {
                fileMd5 = getFileMD5(filePath);
            } catch (Exception e) {
            }
        }

        String originMd5 = null;
        try {
            originMd5 = getFileStreamMD5(is);
        } catch (Exception e) {
        }

        if (!TextUtils.isEmpty(fileMd5) && !TextUtils.isEmpty(originMd5) && fileMd5.equals(originMd5)) {
            result = true;
        }

        return result;
    }

    private static String getMD5String(byte[] bytes) {
        messagedigest.update(bytes);
        return bufferToHex(messagedigest.digest());
    }

    private static String bufferToHex(byte bytes[]) {
        return bufferToHex(bytes, 0, bytes.length);
    }

    private static String bufferToHex(byte bytes[], int m, int n) {
        StringBuffer stringbuffer = new StringBuffer(2 * n);
        int k = m + n;
        for (int l = m; l < k; l++) {
            appendHexPair(bytes[l], stringbuffer);
        }
        return stringbuffer.toString();
    }

    private static void appendHexPair(byte bt, StringBuffer stringbuffer) {
        char c0 = hexDigits[(bt & 0xf0) >> 4];
        char c1 = hexDigits[bt & 0xf];
        stringbuffer.append(c0);
        stringbuffer.append(c1);
    }
}
