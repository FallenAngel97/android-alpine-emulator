FROM alvrme/alpine-android:android-33-jdk8
RUN sdkmanager --install 'system-images;android-26;google_apis;arm64-v8a' \
 && wget https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-amd64_linux.tar.xz \
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
