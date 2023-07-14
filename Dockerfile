FROM alvrme/alpine-android:android-33-jdk8
RUN sdkmanager --install 'system-images;android-26;google_apis;arm64-v8a' \
 && echo "y" | sdkmanager --licenses \
 && echo no | avdmanager create avd --force \
        --name lowEndOreo \
        --abi google_apis/armeabi-v7a \
        --package 'system-images;android-26;google_apis;armeabi-v7a' \
        --device '2.7in QVGA' \
 && wget https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-amd64_linux.tar.xz \
 && sed -i '/hw.audioInput=yes/c\hw.audioInput=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.audioOutput=yes/c\hw.audioOutput=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.gyroscope=yes/c\hw.gyroscope=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && sed -i '/hw.accelerometer=yes/c\hw.accelerometer=no' /root/.android/avd/lowEndOreo.avd/config.ini \
 && tar -xf upx-4.0.2-amd64_linux.tar.xz \
 && cd upx-4.0.2-amd64_linux \
 && ./upx --ultra-brute /opt/sdk/platform-tools/adb \
 && ./upx --ultra-brute $ANDROID_HOME/emulator/emulator \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/aapt2 \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/aapt \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/aidl \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/split-select \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/llvm-rs-cc \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/dexdump \
 && ./upx --ultra-brute /opt/sdk/build-tools/33.0.2/zipalign \
 && rm -rf /opt/sdk/cmdline-tools/8.0/bin \
 && rm -rf /opt/sdk/build-tools/33.0.2/NOTICE.txt \
 && rm -rf /opt/sdk/platform-tools/NOTICE.txt \
 && cd .. && rm -rf upx-4.0.2-amd64_linux

CMD "adb start-server"
