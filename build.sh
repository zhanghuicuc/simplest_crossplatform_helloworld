./build_sch_android.sh
./build_sch_android.sh armeabi-v7a

./build_sch_ios.sh
./build_sch_ios.sh armv7
./build_sch_ios.sh i386
./build_sch_ios.sh x86_64
xcrun lipo -create install/ios/arm64/lib/libschdemo.a \
        install/ios/armv7/lib/libschdemo.a \
        install/ios/i386/lib/libschdemo.a \
        install/ios/x86_64/lib/libschdemo.a -output install/ios/libschdemo_uni.a