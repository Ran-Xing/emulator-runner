## Emulator Runner

Android Studio Virtual Device Emulator Runner

<details>
<summary>调试说明</summary>

1. Applications 文件夹下必须要有 类似 `Android 13.app` 文件夹
2. `Android 13.app` 文件夹可以从 release 下载
3. electron安装可使用镜像源`yarn config set electron_mirror https://npm.taobao.org/mirrors/electron/`
4. adb 技术资料 https://github.com/mzlogin/awesome-adb
</details>

<details>
<summary>TODO</summary>

- [ ] nodejs 读取ini配置文件
- [ ] EmulateConfig 路由参数传递问题 传递ID和 emulatorLists 或者直接传个JSON 过去, 如果有变更就提示 保存, 没有变更就不提示
- [ ] `console` 提示的几个问题
</details>

<details>
<summary>REQ</summary>

1. [Android Studio](https://developer.android.com/studio)
2. [Android SDK](https://developer.android.com/studio/releases/platform-tools)
3. [Android Emulator](https://developer.android.com/studio/run/emulator)
4. [Android Emulator Command-line](https://developer.android.com/studio/run/emulator-commandline)
5. [Start the emulator from the command line](https://developer.android.com/studio/run/emulator-commandline)
6. [Android Emulator Config](https://developer.android.com/studio/run/emulator-commandline#startup-options)
7. [XML Config](https://dl.google.com/android/repository/addons_list-5.xml)
8. [Android 12 System Image](https://dl.google.com/android/repository/sys-img/android/x86_64-32_r01.zip)
9[Android 12 System Image With Google API](https://dl.google.com/android/repository/sys-img/google_apis/x86_64-32_r07.zip)
</details>

<details>
<summary>Android Api Map</summary>

- Android 5.1 (Lollipop): API level 22
- Android 6.0 (Marshmallow): API level 23
- Android 7.0 (Nougat): API level 24
- Android 7.1 (Nougat): API level 25
- Android 8.1 (Oreo): API level 27
- Android 9 (Pie): API level 28
- Android 10: API level 29
- Android 11: API level 30
- Android 12: API level 32
- Android 13: API level 33
- Android 14: API level 34
</details>



