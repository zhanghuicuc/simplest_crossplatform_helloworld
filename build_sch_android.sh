basepath=$(cd `dirname $0`; pwd)
echo "${basepath}"

target="arm64-v8a"
if [ $# -gt 0 ];then
    target=$1
    echo "build target ${target}"
fi

if [ -d ./install/android/"${target}" ];then
    rm -rf install/android/"${target}"
fi

if [ -d ./android_build ];then
    rm -rf android_build
fi

mkdir android_build

cd android_build

${ANDROID_SDK_HOME}/cmake/3.10.2.4988404/bin/cmake ../sch/ \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="$target" \
    -DANDROID_PLATFORM=21 \
    -DTARGET_ABI=${target} \
    -DCMAKE_INSTALL_PREFIX=${basepath}/install/android/"$target"

make -j4
make install