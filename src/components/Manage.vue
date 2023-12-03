<script setup lang="ts">
const {exec} = require('child_process');

function test() {
  console.log('执行adb命令来获取截图')
  exec('adb shell screencap -p /sdcard/DCIM/screenshot.png', (error: any) => {
    if (error) {
      console.error(`执行命令时出错：${error}`);
      return;
    }
    // 从设备中将截图文件拷贝到电脑
    // TODO 将图片放到程序静态资源文件中
    exec('adb pull /sdcard/DCIM/screenshot.png /tmp/screenshot.png', (error: any) => {
      if (error) {
        console.error(`执行命令时出错：${error}`);
        return;
      }
      console.log('截图已保存到电脑桌面');
      exec('adb shell rm /sdcard/DCIM/screenshot.png', (error: any) => {
        if (error) {
          console.error(`执行命令时出错：${error}`);
          return;
        }
        console.log('截图已从设备中删除');
      });
    });
  });
}
</script>

<template>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <botton @click="test">Manage</botton>
</template>

<style scoped>

</style>