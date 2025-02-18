#!/bin/bash

aicommit

if [[ $1 =~ "+" ]]; then
  dart ./script/increaseVersion.dart
fi

vcm build\&upload -epy8

# export https_proxy=http://127.0.0.1:33210 http_proxy=http://127.0.0.1:33210 all_proxy=socks5://127.0.0.1:33211

if [[ $1 =~ "a" ]]; then
  echo "打包安卓中(flutter build apk)..."
  flutter build apk
  echo "APK上传中(到fir.im)..."
  fir publish ./build/app/outputs/apk/release/app-release.apk |
    awk '/Uploading app:/{gsub("Uploading app: ", ""); print} /Published succeed:/{gsub("Published succeed: ", ""); print}' |
    awk -F'INFO -- : ' '{print $2}'
fi

if [[ $1 =~ "g" ]]; then
  echo "打包安卓中(flutter build appbundle)..."
  flutter build appbundle
fi

if [[ $1 =~ "i" ]]; then
  echo "打包iOS中(flutter build ipa)..."
  flutter build ipa
  open ./build/ios/archive/Runner.xcarchive
fi

if [[ $1 =~ "i" ]]; then
  echo "iOS产物大小："
  du -sh ./build/ios/archive/Runner.xcarchive
fi

if [[ $1 =~ "a" ]]; then
  echo "Android产物大小："
  du -h ./build/app/outputs/apk/release/app-release.apk
  open ./build/app/outputs/apk/release/
fi

if [[ $1 =~ "g" ]]; then
  echo "AppBundle产物大小："
  du -h ./build/app/outputs/bundle/release/app-release.aab
  open ./build/app/outputs/bundle/release/
fi



