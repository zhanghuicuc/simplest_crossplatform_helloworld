cmake_minimum_required(VERSION 3.7.1 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 11)
project(liblogJNI C CXX)

set(sch_location "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../install/android/arm64-v8a/include")
set(sch_binaries "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../install/android/${ANDROID_ABI}/lib")
message(${PROJECT_SOURCE_DIR})

add_definitions(-D SCH_PLATFORM_ANDROID)

foreach(sch_lib schdemo)
    set(sch_lib_filename lib${sch_lib}.a)
    set(sch_lib_file_path ${sch_binaries}/${sch_lib_filename})
    add_library(
            ${sch_lib}
            STATIC
            IMPORTED)
    set_target_properties(
            ${sch_lib} PROPERTIES
            IMPORTED_LOCATION
            ${sch_lib_file_path})
endforeach()

include_directories(${sch_location})
message(${sch_location})
find_library(android_log_lib log)

if(CMAKE_ANDROID_NDK)
    list(APPEND PLATFORM_LIBS c++abi)
else()
    list(APPEND PLATFORM_LIBS ${CMAKE_CXX_IMPLICIT_LINK_LIBRARIES})
endif()

add_library(logJNI
        SHARED
        log_jni.cpp
        )

target_link_libraries(logJNI
        android
        schdemo
        ${android_log_lib}
        ${PLATFORM_LIBS})