package com.z.zz.zzz.BridgeX;

import android.util.Log;

import zhao.zizzy.bridgex.LogBridge;

public class LoggerImpl implements LogBridge.ILogger {

    @Override
    public void log(Object source) {
        Log.d("LoggerImpl", "lalala: " + source);
    }

    @Override
    public void log(Object... args) {
        Log.d("LoggerImpl", "lalala: " + args);
    }

    @Override
    public void log(String tag, Object source) {
        Log.d("LoggerImpl", "lalala: " + tag + " " + source);
    }
}
