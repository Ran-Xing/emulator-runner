#!/usr/bin/env bash

# set color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
COL_NC='\033[0m' # No Color
COL_LIGHT_YELLOW='\033[1;33m'
INFO="[${COL_LIGHT_YELLOW}~${COL_NC}]"
OVER="\r\033[K"
printf "\033[H\033[2J" # 清理屏幕
# set msg
msg_info() {
    printf "  ${INFO}  %s ${COL_LIGHT_YELLOW}...${COL_NC}" "${1}" 1>&2
}

msg_over() {
    printf "${OVER}%s" "" 1>&2
}
msg_last() {
    for ((i = 1; i <= ${1}; i++)); do
        printf "\r\033[1A%s" "" 1>&2
        printf "\r\033[K%s" "" 1>&2
    done
}

msg_ok() {
    printf "${OVER}  [\033[1;32m✓${COL_NC}]  %s\n" "${1}" 1>&2
    msg_over
}

msg_err() {
    printf "${OVER}  [\033[1;31m✗${COL_NC}]  %s\n" "${1}" 1>&2
    exit 1
}

makeIcns() {
    mkdir icons.iconset/
    sips -z 16 16 "${appIcons}" --out icons.iconset/icon_16x16.png >/dev/null 2>&1
    sips -z 32 32 "${appIcons}" --out icons.iconset/icon_16x16@2x.png >/dev/null 2>&1
    sips -z 32 32 "${appIcons}" --out icons.iconset/icon_32x32.png >/dev/null 2>&1
    sips -z 64 64 "${appIcons}" --out icons.iconset/icon_32x32@2x.png >/dev/null 2>&1
    sips -z 64 64 "${appIcons}" --out icons.iconset/icon_64x64.png >/dev/null 2>&1
    sips -z 128 128 "${appIcons}" --out icons.iconset/icon_64x64@2x.png >/dev/null 2>&1
    sips -z 128 128 "${appIcons}" --out icons.iconset/icon_128x128.png >/dev/null 2>&1
    sips -z 256 256 "${appIcons}" --out icons.iconset/icon_128x128@2x.png >/dev/null 2>&1
    sips -z 256 256 "${appIcons}" --out icons.iconset/icon_256x256.png >/dev/null 2>&1
    sips -z 512 512 "${appIcons}" --out icons.iconset/icon_256x256@2x.png >/dev/null 2>&1
    sips -z 512 512 "${appIcons}" --out icons.iconset/icon_512x512.png >/dev/null 2>&1
    sips -z 1024 1024 "${appIcons}" --out icons.iconset/icon_512x512@2x.png >/dev/null 2>&1
    iconutil -c icns icons.iconset -o "dist/${appName}.icns"
    cp "${appIcons}" "dist/${appName}.png"
    rm -rf icons.iconset
}

repo=https://dl.google.com/android/repository/


msg_info 正在初始化资源文件
echo
find "${PWD}" -name ".DS_Store" -exec rm -v "{}" \;
ANDROID_SDK_ROOT="${HOME}/Library/Android/sdk"
if [ ! -d "${ANDROID_SDK_ROOT}" ]; then mkdir -p "${ANDROID_SDK_ROOT}"; fi
if [ ! -d "tmp" ]; then mkdir tmp; fi
if [ ! -d "dist" ]; then mkdir dist; fi
if [ ! -d "${ANDROID_SDK_ROOT}/emulator" ]; then
      emulator_url=https://dl.google.com/android/repository/emulator-darwin_aarch64-10696886.zip
    if [ "$(arch)" != "arm64" ]; then
      emulator_url=https://dl.google.com/android/repository/emulator-darwin_x64-10696886.zip
    fi
    if [ ! -e "tmp/emulator.zip" ]; then curl -kfsSL "${emulator_url}" -o tmp/emulator.zip; fi
    unzip -q "tmp/emulator.zip" -d "${ANDROID_SDK_ROOT}"

fi
if [ ! -d "${ANDROID_SDK_ROOT}/platform-tools" ]; then
    if [ ! -e "tmp/platform-tools.zip" ]; then curl -kfsSL https://dl.google.com/android/repository/platform-tools_r34.0.4-darwin.zip -o tmp/platform-tools.zip; fi
    unzip -q "tmp/platform-tools.zip" -d "${ANDROID_SDK_ROOT}"
fi
#if [ ! -d "${ANDROID_SDK_ROOT}/skins" ]; then
#    cp -r src/Android.app/Contents/MacOS/skins "${ANDROID_SDK_ROOT}/" # TODO
#else
#    if [ ! -d "${ANDROID_SDK_ROOT}/skins/pixel_4_xl" ]; then
#        cp -r src/Android.app/Contents/MacOS/skins/pixel_4_xl "${ANDROID_SDK_ROOT}/skins/" # TODO
#    fi
#fi
if [ ! -d "${ANDROID_SDK_ROOT}/platforms" ]; then
    mkdir "${ANDROID_SDK_ROOT}/platforms"
fi

if [ -z "$1" ]; then
    echo "    请选择创建的系统版本"
    options=("Android 5" "Android 5 Google" "Android 6" "Android 6 Google" "Android 7" "Android 7 Google" "Android 8" "Android 8 Google" "Android 9" "Android 9 Google" "Android 10" "Android 10 Google" "Android 11" "Android 11 Google" "Android 12" "Android 12 Google" "Android 13" "Android 13 Google" "Android 14" "Android 14 Google" "Quit")
    select opt in "${options[@]}"; do
        break
    done
    msg_last 9
    msg_info "您选择了: ${opt}"
else
    opt=$1
fi

case $opt in
"Android 5")
    system_images=Android5
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-22_r02.zip"
    system_images_path="system-images/android-22/default/arm64-v8a"
    ;;
"Android 5 Google")
    system_images=Android5_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis/arm64-v8a-22_r26.zip"
    system_images_path="system-images/android-22/google_apis/arm64-v8a"
    ;;
"Android 6")
    system_images=Android6
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-23_r07.zip"
    system_images_path="system-images/android-23/default/arm64-v8a"
    ;;
"Android 6 Google")
    system_images=Android6_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis/arm64-v8a-23_r33.zip"
    system_images_path="system-images/android-23/google_apis/arm64-v8a"
    ;;
"Android 7")
    system_images=Android7
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-25_r02.zip"
    system_images_path="system-images/android-25/default/arm64-v8a"
    ;;
"Android 7 Google")
    system_images=Android7_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis/arm64-v8a-25_r20.zip"
    system_images_path="system-images/android-25/google_apis/arm64-v8a"
    ;;
"Android 8")
    system_images=Android8
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-27_r02.zip"
    system_images_path="system-images/android-27/default/arm64-v8a"
    ;;
"Android 8 Google")
    system_images=Android8_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis/arm64-v8a-27_r03.zip"
    system_images_path="system-images/android-27/google_apis/arm64-v8a"
    ;;
"Android 9")
    system_images=Android9
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-28_r02.zip"
    system_images_path="system-images/android-28/default/arm64-v8a"
    ;;
"Android 9 Google")
    system_images=Android9_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-28_r02.zip"
    system_images_path="system-images/android-28/google_apis_playstore/arm64-v8a"
    ;;
"Android 10")
    system_images=Android10
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-29_r08.zip"
    system_images_path="system-images/android-29/default/arm64-v8a"
    ;;
"Android 10 Google")
    system_images=Android10_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-29_r09-darwin.zip"
    system_images_path="system-images/android-29/google_apis_playstore/arm64-v8a"
    ;;
"Android 11")
    system_images=Android11
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-30_r02.zip"
    system_images_path="system-images/android-30/default/arm64-v8a"
    ;;
"Android 11 Google")
    system_images=Android11_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-30_r10-darwin.zip"
    system_images_path="system-images/android-30/google_apis_playstore/arm64-v8a"
    ;;
"Android 12")
    system_images=Android12
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-32_r01.zip"
    system_images_path="system-images/android-32/default/arm64-v8a"
    ;;
"Android 12 Google")
    system_images=Android12_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-32_r03-darwin.zip"
    system_images_path="system-images/android-32/google_apis_playstore/arm64-v8a"
    ;;
"Android 13")
    system_images=Android13
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-33_r02.zip"
    system_images_path="system-images/android-33/default/arm64-v8a"
    ;;
"Android 13 Google")
    system_images=Android13_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-33_r07-darwin.zip"
    system_images_path="system-images/android-33/google_apis_playstore/arm64-v8a"
    ;;
"Android 14")
    system_images=Android14
    system_images_url="https://dl.google.com/android/repository/sys-img/android/arm64-v8a-34_r04.zip"
    system_images_path="system-images/android-34/default/arm64-v8a"
    ;;
"Android 14 Google")
    system_images=Android14_google
    system_images_url="https://dl.google.com/android/repository/sys-img/google_apis_playstore/arm64-v8a-34_r12-darwin.zip"
    system_images_path="system-images/android-34/google_apis_playstore/arm64-v8a"
    ;;
"Quit")
    exit 0
    ;;
*)
    echo "Invalid option"
    exit 0
    ;;
esac

target="$(echo "${system_images_path}" | awk -F '/' '{print $2}')"
if [ ! -d "${ANDROID_SDK_ROOT}/${system_images_path%/*}" ]; then
    if [ ! -e "tmp/${system_images}.zip" ]; then
        curl -kfsSL "${system_images_url}" -o "tmp/${system_images}.zip"
    fi
    mkdir -p "${ANDROID_SDK_ROOT}/${system_images_path%/*}"
    unzip -q "tmp/${system_images}.zip" -d "${ANDROID_SDK_ROOT}/${system_images_path%/*}"
fi

msg_ok 初始化完成!

msg_info 正在设置APP信息
echo

if [ -z "$2" ]; then
    read -p "    请设置APP名称 示例: 三国志 战略版 : " -r appName
    msg_last 1
else
    appName=$2
fi
msg_ok "APP名称: ${appName}"

if [ -z "$3" ]; then
    read -p "    请设置APP图标 将PNG图标文件拖动到这里, 然后回车; 没有的话就回车: " -r appIcons
    msg_last 1
else
    appIcons=$3
fi

app_id="$((RANDOM % 1000 + 1000))"

if [ ! -d "dist/${appName}.app" ]; then
    cp -r src/Android.app "dist/${appName}.app"
else
    rm -rf "dist/${appName}.app"
    cp -r "src/Android.app" "dist/${appName}.app"
fi

if [ -z "$appIcons" ]; then
    msg_ok "APP图标: 默认"
    if [ -e "dist/${appName}.icns" ]; then
        cp "dist/${appName}.icns" "dist/${appName}.app/Contents/Resources/ApplicationStub.icns"
    fi
    if [ -e "dist/${appName}.png" ]; then
        cp "dist/${appName}.png" "dist/${appName}.app/Contents/Resources/ApplicationStub.png"
    fi
else
    if [ ! -e "dist/${appName}.icns" ]; then
        appIcons="$(echo "${appIcons}" | sed "s/'//g")"
        msg_ok "APP图标: ${appIcons}"
        makeIcns
    else
        msg_ok "APP图标: dist/${appName}.icns"
    fi

    cp "dist/${appName}.icns" "dist/${appName}.app/Contents/Resources/ApplicationStub.icns"
    cp "dist/${appName}.png" "dist/${appName}.app/Contents/Resources/ApplicationStub.png"
fi

sed -i '' "s/=Android/=${appName}/g" "dist/${appName}.app/Contents/MacOS/avd/Android.avd/config.ini"
sed -i '' "s|image.sysdir.1=system_images_path|image.sysdir.1=${system_images_path}|g" "dist/${appName}.app/Contents/MacOS/avd/Android.avd/config.ini"
sed -i '' "s/Android/${system_images}_${app_id}/g" "dist/${appName}.app/Contents/MacOS/avd/Android.ini"
sed -i '' "s/android-22/${target}/g" "dist/${appName}.app/Contents/MacOS/avd/Android.ini"
sed -i '' "s|-avd Android|-avd ${system_images}_${app_id}|g" "dist/${appName}.app/Contents/MacOS/runemu"
sed -i '' "s|system_images=system_images|system_images=${system_images}|g" "dist/${appName}.app/Contents/MacOS/runemu" # TODO Android 12 Google PlayStore 真的叫 Android12_google 吗
sed -i '' "s|system_images_url=system_images_url|system_images_url=\"${system_images_url}\"|g" "dist/${appName}.app/Contents/MacOS/runemu"
sed -i '' "s|system_images_path=system_images_path|system_images_path=\"${system_images_path}\"|g" "dist/${appName}.app/Contents/MacOS/runemu"
mv "dist/${appName}.app/Contents/MacOS/avd/Android.avd" "dist/${appName}.app/Contents/MacOS/avd/${system_images}_${app_id}.avd"
mv "dist/${appName}.app/Contents/MacOS/avd/Android.ini" "dist/${appName}.app/Contents/MacOS/avd/${system_images}_${app_id}.ini"

msg_ok APP信息加载完成
open dist
