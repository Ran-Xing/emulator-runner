#!/usr/bin/env bash

cd "${0%/*}"
rm -rf dist

./start.sh "Android 5" "Android 5" "src/img/Android.png"
./start.sh "Android 5 Google" "Android 5 Google" "src/img/Android.png"
./start.sh "Android 6" "Android 6" "src/img/Android.png"
./start.sh "Android 6 Google" "Android 6 Google" "src/img/Android.png"
./start.sh "Android 7" "Android 7" "src/img/Android.png"
./start.sh "Android 7 Google" "Android 7 Google" "src/img/Android.png"
./start.sh "Android 8" "Android 8" "src/img/Android.png"
./start.sh "Android 8 Google" "Android 8 Google" "src/img/Android.png"
./start.sh "Android 9" "Android 9" "src/img/Android.png"
./start.sh "Android 9 Google" "Android 9 Google" "src/img/Android.png"
./start.sh "Android 10" "Android 10" "src/img/Android.png"
./start.sh "Android 10 Google" "Android 10 Google" "src/img/Android.png"
./start.sh "Android 11" "Android 11" "src/img/Android.png"
./start.sh "Android 11 Google" "Android 11 Google" "src/img/Android.png"
./start.sh "Android 12" "Android 12" "src/img/Android.png"
./start.sh "Android 12 Google" "Android 12 Google" "src/img/Android.png"
./start.sh "Android 13" "Android 13" "src/img/Android.png"
./start.sh "Android 13 Google" "Android 13 Google" "src/img/Android.png"
./start.sh "Android 14" "Android 14" "src/img/Android.png"
./start.sh "Android 14 Google" "Android 14 Google" "src/img/Android.png"
./start.sh "Android 5" "三国志·战略版" "src/img/sgz.png"
./start.sh "Android 5" "金铲铲之战" "src/img/jcc.png"
./start.sh "Android 12" "穿越火线 枪战王者" "src/img/cfm.png"
./start.sh "Android 5" "咸鱼" "src/img/xy.png"
./start.sh "Android 5" "咸鱼2" "src/img/xy.png"
./start.sh "Android 5" "咸鱼3" "src/img/xy.png"

cd dist
create-dmg \
  --volname "Android 5" \
  --volicon "Android 5.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 5.app" 200 190 \
  --hide-extension "Android 5.app" \
  --app-drop-link 600 185 \
  "Android 5.dmg" \
  "Android 5.app"
create-dmg \
  --volname "Android 5 Google" \
  --volicon "Android 5 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 5 Google.app" 200 190 \
  --hide-extension "Android 5 Google.app" \
  --app-drop-link 600 185 \
  "Android 5 Google.dmg" \
  "Android 5 Google.app"
create-dmg \
  --volname "Android 6" \
  --volicon "Android 6.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 6.app" 200 190 \
  --hide-extension "Android 6.app" \
  --app-drop-link 600 185 \
  "Android 6.dmg" \
  "Android 6.app"
create-dmg \
  --volname "Android 6 Google" \
  --volicon "Android 6 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 6 Google.app" 200 190 \
  --hide-extension "Android 6 Google.app" \
  --app-drop-link 600 185 \
  "Android 6 Google.dmg" \
  "Android 6 Google.app"
create-dmg \
  --volname "Android 7" \
  --volicon "Android 7.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 7.app" 200 190 \
  --hide-extension "Android 7.app" \
  --app-drop-link 600 185 \
  "Android 7.dmg" \
  "Android 7.app"
create-dmg \
  --volname "Android 7 Google" \
  --volicon "Android 7 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 7 Google.app" 200 190 \
  --hide-extension "Android 7 Google.app" \
  --app-drop-link 600 185 \
  "Android 7 Google.dmg" \
  "Android 7 Google.app"
create-dmg \
  --volname "Android 8" \
  --volicon "Android 8.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 120 \
  --icon "Android 8.app" 200 190 \
  --hide-extension "Android 8.app" \
  --app-drop-link 600 185 \
  "Android 8.dmg" \
  "Android 8.app"
create-dmg \
  --volname "Android 8 Google" \
  --volicon "Android 8 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 8 Google.app" 200 190 \
  --hide-extension "Android 8 Google.app" \
  --app-drop-link 600 185 \
  "Android 8 Google.dmg" \
  "Android 8 Google.app"
create-dmg \
  --volname "Android 9" \
  --volicon "Android 9.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 9.app" 200 190 \
  --hide-extension "Android 9.app" \
  --app-drop-link 600 185 \
  "Android 9.dmg" \
  "Android 9.app"
create-dmg \
  --volname "Android 9 Google" \
  --volicon "Android 9 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 9 Google.app" 200 190 \
  --hide-extension "Android 9 Google.app" \
  --app-drop-link 600 185 \
  "Android 9 Google.dmg" \
  "Android 9 Google.app"
create-dmg \
  --volname "Android 10" \
  --volicon "Android 10.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 10.app" 200 190 \
  --hide-extension "Android 10.app" \
  --app-drop-link 600 185 \
  "Android 10.dmg" \
  "Android 10.app"
create-dmg \
  --volname "Android 10 Google" \
  --volicon "Android 10 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 10 Google.app" 200 190 \
  --hide-extension "Android 10 Google.app" \
  --app-drop-link 600 185 \
  "Android 10 Google.dmg" \
  "Android 10 Google.app"
create-dmg \
  --volname "Android 11" \
  --volicon "Android 11.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 11.app" 200 190 \
  --hide-extension "Android 11.app" \
  --app-drop-link 600 185 \
  "Android 11.dmg" \
  "Android 11.app"
create-dmg \
  --volname "Android 11 Google" \
  --volicon "Android 11 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 11 Google.app" 200 190 \
  --hide-extension "Android 11 Google.app" \
  --app-drop-link 600 185 \
  "Android 11 Google.dmg" \
  "Android 11 Google.app"
create-dmg \
  --volname "Android 12" \
  --volicon "Android 12.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 12.app" 200 190 \
  --hide-extension "Android 12.app" \
  --app-drop-link 600 185 \
  "Android 12.dmg" \
  "Android 12.app"
create-dmg \
  --volname "Android 12 Google" \
  --volicon "Android 12 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 12 Google.app" 200 190 \
  --hide-extension "Android 12 Google.app" \
  --app-drop-link 600 185 \
  "Android 12 Google.dmg" \
  "Android 12 Google.app"
create-dmg \
  --volname "Android 13" \
  --volicon "Android 13.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 13.app" 200 190 \
  --hide-extension "Android 13.app" \
  --app-drop-link 600 185 \
  "Android 13.dmg" \
  "Android 13.app"
create-dmg \
  --volname "Android 13 Google" \
  --volicon "Android 13 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 13 Google.app" 200 190 \
  --hide-extension "Android 13 Google.app" \
  --app-drop-link 600 185 \
  "Android 13 Google.dmg" \
  "Android 13 Google.app"
create-dmg \
  --volname "Android 14" \
  --volicon "Android 14.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Android 14.app" 200 190 \
  --hide-extension "Android 14.app" \
  --app-drop-link 600 185 \
  "Android 14.dmg" \
  "Android 14.app"
create-dmg \
  --volname "Android 14 Google" \
  --volicon "Android 14 Google.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 500 \
  --icon-size 120 \
  --icon "Android 14 Google.app" 200 190 \
  --hide-extension "Android 14 Google.app" \
  --app-drop-link 600 185 \
  "Android 14 Google.dmg" \
  "Android 14 Google.app"
create-dmg \
  --volname "三国志·战略版" \
  --volicon "三国志·战略版.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "三国志·战略版.app" 200 190 \
  --hide-extension "三国志·战略版.app" \
  --app-drop-link 600 185 \
  "三国志·战略版.dmg" \
  "三国志·战略版.app"
create-dmg \
  --volname "金铲铲之战" \
  --volicon "金铲铲之战.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "金铲铲之战.app" 200 190 \
  --hide-extension "金铲铲之战.app" \
  --app-drop-link 600 185 \
  "金铲铲之战.dmg" \
  "金铲铲之战.app"
create-dmg \
  --volname "穿越火线 枪战王者" \
  --volicon "穿越火线 枪战王者.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "穿越火线 枪战王者" 200 190 \
  --hide-extension "穿越火线 枪战王者.app" \
  --app-drop-link 600 185 \
  "穿越火线 枪战王者.dmg" \
  "穿越火线 枪战王者.app"

create-dmg \
  --volname "咸鱼" \
  --volicon "咸鱼.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "咸鱼" 200 190 \
  --hide-extension "咸鱼.app" \
  --app-drop-link 600 185 \
  "咸鱼.dmg" \
  "咸鱼.app"
create-dmg \
  --volname "咸鱼2" \
  --volicon "咸鱼2.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "咸鱼2" 200 190 \
  --hide-extension "咸鱼2.app" \
  --app-drop-link 600 185 \
  "咸鱼2.dmg" \
  "咸鱼2.app"
create-dmg \
  --volname "咸鱼3" \
  --volicon "咸鱼3.icns" \
  --background "../src/img/banner.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "咸鱼3" 200 190 \
  --hide-extension "咸鱼3.app" \
  --app-drop-link 600 185 \
  "咸鱼3.dmg" \
  "咸鱼3.app"

if [ "${GITHUB_WORKSPACE}" != "" ] && [ "${GITHUB_WORKSPACE}" != "" ]; then
  echo "GitHub Action Build"
  mv "穿越火线 枪战王者.dmg" cfm.dmg
  mv "金铲铲之战.dmg" jcc.dmg
  mv "三国志·战略版.dmg" sgz.dmg
  mv "咸鱼.dmg" xianyu.dmg
  mv "咸鱼2.dmg" xianyu2.dmg
  mv "咸鱼3.dmg" xianyu3.dmg
fi
