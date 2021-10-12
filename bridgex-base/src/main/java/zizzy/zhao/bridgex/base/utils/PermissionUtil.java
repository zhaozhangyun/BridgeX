package zizzy.zhao.bridgex.base.utils;

import static android.os.Build.VERSION_CODES.M;

import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

public class PermissionUtil {

    /**
     * Determines if the context calling has the required permission
     *
     * @param context    - the IPC context
     * @param permission - The permission to check
     * @return true if the IPC has the granted permission
     */
    private static boolean hasPermission(Context context, String permission) {
        int res = context.checkCallingOrSelfPermission(permission);
        Log.i("Permission", permission + " \t\t " +
                (res == PackageManager.PERMISSION_GRANTED ? "[GRANTED]" : "[DENIED]"));
        return res == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * Determines if the context calling has the required permissions
     *
     * @param context     - the IPC context
     * @param permissions - The permissions to check
     * @return true if the IPC has the granted permission
     */
    private static boolean hasPermissions(Context context, String... permissions) {
        boolean hasAllPermissions = true;
        for (String permission : permissions) {
            //you can return false instead of assigning, but by assigning you can log all permission values
            if (!hasPermission(context, permission)) {
                hasAllPermissions = false;
            }
        }
        return hasAllPermissions;
    }

    public static boolean checkSelfPermissions(Context context, String... permissions) {
        if (Build.VERSION.SDK_INT >= M) {
            if (hasPermissions(context, permissions)) {
                return true;
            } else {
                return false;
            }
        }
        return true;
    }
}
