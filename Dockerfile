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
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-aarch64 \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-armel \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-x86_64 \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-i386 \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-aarch64-headless \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-armel-headless \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-x86_64-headless \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/qemu/linux-x86_64/qemu-system-i386-headless \
 && rm -rf /opt/sdk/cmdline-tools \
 && rm -rf /opt/sdk/build-tools \
 && rm -rf /opt/sdk/platform-tools/NOTICE* /opt/sdk/platform-tools/fastboot /opt/sdk/platform-tools/sqlite3 /opt/sdk/platform-tools/LICENSE \
 && rm -rf /opt/sdk/platforms/android-33/templates/NOTICE.txt \
 && rm -rf /opt/sdk/system-images/android-26/google_apis/arm64-v8a/NOTICE.txt \
 && rm -rf /root/.wget-hsts \
 && cd .. && rm -rf upx-4.0.2-amd64_linux

CMD "adb start-server"
