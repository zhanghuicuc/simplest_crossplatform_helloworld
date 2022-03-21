package com.example.zhanghui.schdemo;

public class LogUtil {

    static {
        System.loadLibrary("c++_shared");
        System.loadLibrary("logJNI");
    }

    public static void i(String msg) {
        nativelog(msg);
    }

    private static native void nativelog(String msg);
}
