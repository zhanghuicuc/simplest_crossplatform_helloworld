//
// Created by zhanghui on 2022/3/20.
//

#ifndef SIMPLEST_CROSSPLATFORM_HELLOWORLD_LOGGER_HPP
#define SIMPLEST_CROSSPLATFORM_HELLOWORLD_LOGGER_HPP

#ifdef __cplusplus
extern "C" {
#endif

#include <string.h>

#define filename(x) strrchr(x,'/') ? strrchr(x,'/') + 1 : x

void sch_log(const char* filename, int line, const char* format, ...);

#define SCH_LOGI(format, ...) sch_log(filename(__FILE__), __LINE__, format, ##__VA_ARGS__)

#ifdef __cplusplus
}
#endif

#endif //SIMPLEST_CROSSPLATFORM_HELLOWORLD_LOGGER_HPP
