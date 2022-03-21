//
// Created by zhanghui on 2022/3/20.
//

#include <jni.h>

#include "Logger.hpp"

extern "C"
JNIEXPORT void JNICALL
Java_com_example_zhanghui_schdemo_LogUtil_nativelog(JNIEnv *env, jclass clazz, jstring msg) {
    const char* msg_str = env->GetStringUTFChars(msg, 0);
    SCH_LOGI("%s", msg_str);
    env->ReleaseStringUTFChars(msg, msg_str);
}