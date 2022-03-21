cmake_minimum_required(VERSION 3.7.1 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 11)
project(schdemo C CXX)

message(${PROJECT_SOURCE_DIR})

# used for local debug only
#set(CMAKE_SYSTEM_NAME "Android")
#set(TARGET_ABI "arm64-v8a")
#add_definitions(-D __ANDROID__)
##set(CMAKE_SYSTEM_NAME "iOS")
##set(TARGET_ABI "arm64")
##add_definitions(-D __APPLE__)
#set(jni_location "${ANDROID_NDK_HOME}/sysroot/usr/include")
#message(${jni_location})
#include_directories(${jni_location})

if (CMAKE_SYSTEM_NAME MATCHES "Android")
    message("building for Android")
    add_definitions(-D SCH_PLATFORM_ANDROID)
    find_library(android_log_lib log)
elseif (CMAKE_SYSTEM_NAME MATCHES "iOS")
    message("building for iOS, arch ${TARGET_ABI}")
    add_definitions(-D SCH_PLATFORM_IOS)
endif()

if(CMAKE_ANDROID_NDK)
    list(APPEND PLATFORM_LIBS c++abi)
else()
    list(APPEND PLATFORM_LIBS ${CMAKE_CXX_IMPLICIT_LINK_LIBRARIES})
endif()

add_library(schdemo
        STATIC
        Logger.cpp
        Logger.hpp)
set(header_files
        Logger.hpp)

if (CMAKE_SYSTEM_NAME MATCHES "Android")
    target_link_libraries(schdemo
            android
#            ${android_log_lib}
            ${PLATFORM_LIBS})
elseif (CMAKE_SYSTEM_NAME MATCHES "iOS")
    target_link_libraries(schdemo
            ${PLATFORM_LIBS})
endif()

install(FILES ${header_files} DESTINATION include)
install(TARGETS schdemo
        LIBRARY DESTINATION lib  # 动态库安装路径
        ARCHIVE DESTINATION lib  # 静态库安装路径
        RUNTIME DESTINATION bin  # 可执行文件安装路径
        )