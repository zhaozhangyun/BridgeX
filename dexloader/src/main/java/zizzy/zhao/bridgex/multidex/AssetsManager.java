package zizzy.zhao.bridgex.multidex;

import android.content.Context;
import android.content.res.AssetManager;
import android.text.TextUtils;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;

/**
 * @version $Id: AssetsManager.java, v 0.1 2015年12月11日 下午4:41:10 mochuan.zhb Exp $
 * @Author Zheng Haibo
 * @Company Alibaba Group
 * @PersonalWebsite http://www.mobctrl.net
 * @Description
 */
class AssetsManager {

    static final String TAG = "AssetsManager";
    //文件结尾过滤
    static final String FILE_FILTER = ".dex";
    static final String DEFAULT_ASSETS_DEX_DIR = "bridgex-dex";

    /**
     * 将资源文件中的apk文件拷贝到私有目录中
     */
    static void copyAllAssetsApk(Context context, String codeCacheSecondaryFolderName, String assetsDexDir) {
        AssetManager assetManager = context.getAssets();
        long startTime = System.currentTimeMillis();

        InputStream in = null;
        OutputStream out = null;
        try {
            File dex = context.getDir(codeCacheSecondaryFolderName, Context.MODE_PRIVATE);
            if (!dex.exists()) {
                dex.mkdirs();
            }
            String assetsDexPath = TextUtils.isEmpty(assetsDexDir) ? DEFAULT_ASSETS_DEX_DIR : assetsDexDir;
            Log.v(TAG, "assetsDexPath: " + assetsDexPath);
            String[] fileNames = assetManager.list(assetsDexPath);
            for (String fileName : fileNames) {
                if (!fileName.endsWith(FILE_FILTER)) {
                    continue;
                }
                in = assetManager.open(TextUtils.isEmpty(assetsDexPath) ? fileName
                        : assetsDexPath + "/" + fileName);
                File dexFile = new File(dex, fileName);
                if (MD5.compareToMd5(dexFile, in)) {
                    Log.v(TAG, String.format("[%s] md5 no change", fileName));
                    continue;
                } else if (dexFile.exists()) {
                    Log.v(TAG, String.format("[%s] md5 changed", fileName));
                    String oldDexMd5 = MD5.getFileMD5(dexFile);
                    MultiDeX.clearOldDex(context, oldDexMd5);
                }
                // Because of closing to the InputStream, so open assets again.
                in = assetManager.open(TextUtils.isEmpty(assetsDexPath) ? fileName
                        : assetsDexPath + "/" + fileName);
                out = new FileOutputStream(dexFile);
                byte[] buffer = new byte[2048];
                int read;
                while ((read = in.read(buffer)) != -1) {
                    out.write(buffer, 0, read);
                }
                out.flush();
            }
            Log.i(TAG, String.format("###### install %s from assets/%s cost %dms", Arrays.toString(fileNames),
                    assetsDexPath, (System.currentTimeMillis() - startTime)));
        } catch (Throwable th) {
            th.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (Exception e) {
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (Exception e) {
                }
            }
        }
    }
}
