package zhao.zizzy.bridgex;

import android.content.Context;
import android.util.Log;

import org.json.JSONObject;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;

public class BridgeX {

    private static String DEFAULT_TAG;
    private static boolean DEBUGGABLE;
    private static Logger logger;
    private static Object lock = new Object[0];
    private static Context sContext;
    private static File EXTERNAL_DIR;

    static {
        DEFAULT_TAG = BridgeX.class.getSimpleName();
        DEBUGGABLE = true;
    }

    private static boolean ensureCreated(File folder) {
        if (!folder.exists() && !folder.mkdirs()) {
            Log.e(DEFAULT_TAG, "Unable to create the directory: " + folder.getPath());
            return false;
        } else {
            return true;
        }
    }

    public static void init(Context context) {
        sContext = context;
        if (logger == null) {
            synchronized (lock) {
                if (logger == null) {
                    InputStream is = null;
                    try {
                        is = context.getResources().getAssets().open("bridgex_conf.json");
                        int size = is.available();
                        byte[] buffer = new byte[size];
                        is.read(buffer);
                        JSONObject json = new JSONObject(new String(buffer));
                        DEBUGGABLE = json.optBoolean("debuggable");
                        EXTERNAL_DIR = new File(json.optString("external_dir"));
                        logger = new Logger.LoggerBuilder(context)
                                .defaultTag(json.optJSONObject("logger").optString("default_tag"))
                                .debuggable(DEBUGGABLE)
                                .externalDir(EXTERNAL_DIR.getName())
                                .showAllStack(json.optJSONObject("logger").optBoolean("show_all_stack"))
                                .maxLogStackIndex(json.optJSONObject("logger").optInt("max_stack_index"))
                                .enableStackPackage(json.optJSONObject("logger").optJSONObject("stack_package")
                                        .optBoolean("enable"))
                                .stackPackage(json.optJSONObject("logger").optJSONObject("stack_package")
                                        .optString("package"))
                                .exportJson(json.optJSONObject("logger").optBoolean("export_json"))
                                .build();
                    } catch (Throwable th) {
                        Log.e(DEFAULT_TAG, "parse bridgex_conf.json error", th);
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
        }
    }

    public static String getExternalDatabaseName(String name) {
//        if (ContextCompat.checkSelfPermission(sContext,
//                Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
//                || ContextCompat.checkSelfPermission(sContext,
//                Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
//            return sContext.getDatabasePath(name).getAbsolutePath();
//        }

        if (!ensureCreated(EXTERNAL_DIR)) {
            return sContext.getDatabasePath(name).getAbsolutePath();
        }

        File dbp = new File(EXTERNAL_DIR, "db");
        if (!ensureCreated(dbp)) {
            return sContext.getDatabasePath(name).getAbsolutePath();
        }
        if (DEBUGGABLE) {
            Log.v(DEFAULT_TAG, "dbp=" + dbp);
        }

        return new File(dbp, name).getAbsolutePath();
    }

    public static void writeToFile(String fileName, Object content) {
//        if (ContextCompat.checkSelfPermission(sContext,
//                Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
//                || ContextCompat.checkSelfPermission(sContext,
//                Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
//            return;
//        }

        if (fileName.indexOf(".") != -1) {
            String[] splited = fileName.split("\\.");
            fileName = splited[0] + "_" + System.currentTimeMillis() + "." + splited[1];
        }

        File fileDir = new File(EXTERNAL_DIR, "file");
        if (!ensureCreated(fileDir)) {
            return;
        }

        String fp = new File(fileDir, fileName).getAbsolutePath();
        if (DEBUGGABLE) {
            Log.v(DEFAULT_TAG, "fp=" + fp);
        }

        BufferedWriter out = null;
        try {
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fp), "UTF-8"));
            out.write(content.toString());
        } catch (Throwable th) {
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                }
            }
        }
    }
}
