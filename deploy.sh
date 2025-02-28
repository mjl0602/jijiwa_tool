#!/bin/bash

aicommit

if [[ $1 =~ "+" ]]; then
  dart ./script/increaseVersion.dart
fi

vcm build\&upload -epy8

if [[ $1 =~ "a" ]]; then
  echo "打包安卓中(flutter build apk)..."
  flutter build apk
  echo "APK上传中(到fir.im)..."
  # 使用变量捕捉上传信息
  OUTPUT=$(fir publish ./build/app/outputs/apk/release/app-release.apk)

  # 链接和下载地址
  APP_INFO=$(echo "$OUTPUT" | grep "Uploading app" | awk -F': ' '{print $3}')
  PUBLISH_URL=$(echo "$OUTPUT" | grep "Published succeed" | awk -F': ' '{print $3}')

  echo -e "当前版本: $APP_INFO\n下载链接: $PUBLISH_URL"

  mkdir -p ./release-apk/
  cp ./build/app/outputs/apk/release/app-release.apk "./release-apk/$APP_INFO.apk"

  # 获取当前时间
  CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

  APP_SIZE=$(du -h "./release-apk/$APP_INFO.apk")

  # 将信息写入到文件
  # echo -e "时间: $CURRENT_TIME\n版本: $APP_INFO\n链接: $PUBLISH_URL\n大小: $APP_SIZE\n\n" >>"$FILE_PATH"
  osascript <<EOF
tell application "Stickies"
    activate
    delay 0.5
    tell application "System Events"
        keystroke "n" using {command down}  -- 新建便签
        delay 0.5
        set the clipboard to "时间: $CURRENT_TIME\n版本: $APP_INFO\n链接: $PUBLISH_URL\n大小: $APP_SIZE\n\n"  -- 将内容复制到剪贴板
        delay 0.5
        keystroke "v" using {command down}  -- 粘贴内容
    end tell
end tell
EOF

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
  du -h "./release-apk/$APP_INFO.apk"
fi

open ./build/app/outputs/apk/release/

echo -e "当前版本: $APP_INFO\n下载链接: $PUBLISH_URL" | pbcopy
osascript -e "display notification \"打包完成\" with title \"$APP_INFO\" subtitle \"$PUBLISH_URL\" sound name \"Frog\""
