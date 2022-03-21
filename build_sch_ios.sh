basepath=$(cd `dirname $0`; pwd)
echo "${basepath}"

target="arm64"
if [ $# -gt 0 ];then
    target=$1
    echo "build target ${target}"
fi

platform="OS64"
if [ "${target}" = "i386" ];then
    platform="SIMULATOR"
elif [ "${target}" = "x86_64" ];then
    platform="SIMULATOR64"
elif [ "${target}" = "armv7" ];then
    platform="OS"
fi

if [ -d ./install/ios/"${target}" ];then
    rm -rf install/ios/"${target}"
fi

if [ -d ./ios_build ];then
    rm -rf ios_build
fi

mkdir ios_build

cd ios_build

cmake ../sch/ \
-DCMAKE_TOOLCHAIN_FILE="${basepath}"/third_party/ios-cmake/ios.toolchain.cmake \
-DPLATFORM=${platform} \
-DARCHS=${target} \
-DTARGET_ABI=${target} \
-DENABLE_BITCODE=TRUE \
-DCMAKE_INSTALL_PREFIX="${basepath}"/install/ios/"${target}"

make -j4
make install