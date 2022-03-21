//
// Created by zhanghui on 2022/3/20.
//

#include "Logger.hpp"
#include <string>

#define LOG_TAG "SCH"

#ifdef SCH_PLATFORM_ANDROID
#include "android/log.h"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__);
#endif

void sch_log(const char* filename, int line, const char* format, ...) {
    char buf[1024];
    memset(buf, 0, 1024);

    va_list ap;
    va_start(ap, format);
    vsnprintf(buf, 1024, format, ap);
    va_end(ap);

    std::string log_string;
    log_string += "[" + std::string(filename) + "(" + std::to_string(line) + ")] ";
    log_string += buf;

#ifdef SCH_PLATFORM_ANDROID
    LOGI("%s", log_string.c_str());
#else
    printf("[%s] %s", LOG_TAG, log_string.c_str());
#endif

    fflush(stdout);
    fflush(stderr);
}