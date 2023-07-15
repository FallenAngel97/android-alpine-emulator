FROM alvrme/alpine-android:android-33-jdk8
RUN sdkmanager --install 'system-images;android-26;google_apis;arm64-v8a' \
 && echo "y" | sdkmanager --licenses \
 && echo no | avdmanager create avd --force \
        --name lowEndOreo \
        --abi google_apis/arm64-v8a \
        --package 'system-images;android-26;google_apis;arm64-v8a' \
        --device '2.7in QVGA' \
 && wget https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-amd64_linux.tar.xz \
 && sed -i '/hw.audioInput=yes/c\hw.audioInput=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.audioOutput=yes/c\hw.audioOutput=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.gyroscope=yes/c\hw.gyroscope=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.accelerometer=yes/c\hw.accelerometer=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && tar -xf upx-4.0.2-amd64_linux.tar.xz \
 && cd upx-4.0.2-amd64_linux \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/emulator \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-aarch64 \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-armel \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-x86_64 \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-i386 \
 && rm -rf $ANDROID_HOME/system-images/android-26/google_apis/arm64-v8a/data/app/ApiDemos \
 && rm -rf /var/cache/* \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-aarch64-headless \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-armel-headless \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/lib64/qt/lib/libQt5WebEngineCoreAndroidEmu.so.5 \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/lib64/vulkan/glslangValidator \
 && rm -rf $ANDROID_HOME/system-images/android-26/google_apis/arm64-v8a/userdata.img \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-x86_64-headless \
 && rm -rf $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-i386-headless \
 && rm -rf $ANDROID_HOME/cmdline-tools \
 && rm -rf $ANDROID_HOME/build-tools \
 && rm -rf $ANDROID_HOME/platform-tools/NOTICE* $ANDROID_HOME/platform-tools/fastboot $ANDROID_HOME/platform-tools/sqlite3 $ANDROID_HOME/platform-tools/LICENSE \
 && rm -rf $ANDROID_HOME/platforms/android-33/templates/NOTICE.txt \
 && rm -rf $ANDROID_HOME/system-images/android-26/google_apis/arm64-v8a/NOTICE.txt \
 && rm -rf /root/.wget-hsts \
 && cd .. && rm -rf upx-4.0.2-amd64_linux
