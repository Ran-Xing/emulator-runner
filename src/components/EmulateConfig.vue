<script setup lang="ts">
import {onBeforeRouteLeave} from 'vue-router';
import {i18nSetLocale, t} from '../cli/i18n'
import {openConfig, saveConfig} from "../cli/config";
import Default from "../cli/default";
import {ref, getCurrentInstance, ComponentInternalInstance} from "vue";
import {router} from "../cli/router";
import {string} from "yaml/dist/schema/common/string";
import path from "path";

const memorySelected = ref("4")
const memoryCustom = ref("4")
const memoryCustomIsOpen = ref(false)
const diskSelected = ref("16")
const diskCustom = ref("16")
const diskCustomIsOpen = ref(false)
const displayName = ref("测试")
const oldAvdId = ref("Android_")
const newAvdId = ref("Android_")

function getTextWidth(text: string) {
  const span = document.createElement('span');
  span.style.visibility = 'hidden';
  span.style.position = 'absolute';
  span.style.whiteSpace = 'nowrap';
  span.innerText = text;
  document.body.appendChild(span);
  const width = span.offsetWidth;
  document.body.removeChild(span);
  return width;
}

function displayIdUpdate() {
  // TODO ID 不能重复
  newAvdId.value = "Android_" + String(Math.floor(Math.random() * 1000) + 1000)
  if (oldAvdId.value === newAvdId.value) {
    return
  }
  if (emulatorLists.value[newAvdId.value]) {
    displayId.value = "Android_" + String(Math.floor(Math.random() * 1000) + 1000)
    return
  }
  emulatorLists.value[newAvdId.value] = emulatorLists.value[oldAvdId.value]
  emulatorLists.value[newAvdId.value].avd = newAvdId.value
  emulatorLists.value[newAvdId.value].name = displayName.value
  emulatorLists.value[newAvdId.value].config = emulatorLists.value[newAvdId.value].config.replace(oldAvdId.value, newAvdId.value)

  if (emulatorLists.value[oldAvdId]) {
    delete emulatorLists.value[oldAvdId]
  }
  //   displayId.value = oldAvdId.value
  // delete jsonObj.key2
  //  emulatorLists.value[avdID]??=newavd
  //  emulatorLists.value[avdID]??=newavd
  // mv oldavd.avd newavd.avd
}

function memorySelectedUpdate(key: string, open: boolean, custom: boolean) {
  console.log(`proxySelectedUpdate key [${key}] value [${memoryCustom.value}]`)
  memorySelected.value = key
  // config.value.proxySelected = memorySelected.value
  if (custom) {
    memoryCustomIsOpen.value = open
    return
  }
  if (key === "custom") {
    // memoryCustom.value = memoryCustom.value.trim()
    console.log(`proxySelectedUpdate custokey [${key}] value [${memoryCustom.value}]`)
    // if (memoryCustom.value === "") {
    //   proxyCustom.value = "http://127.0.0.1:1080"
    // }
    setTimeout(() => {
      memoryCustomIsOpen.value = open
    }, 500)
  } else {
    setTimeout(() => {
      memoryCustomIsOpen.value = false
    }, 500)
  }
  // config.value.proxyCustom = proxyCustom.value
  // config.value = saveConfig(config.value)
  // console.log('proxySelectedUpdate save', config.value)
  // reGetConfig()
}

function diskSelectedUpdate(key: string, open: boolean, custom: boolean) {
  console.log(`proxySelectedUpdate key [${key}] value [${diskCustom.value}]`)
  diskSelected.value = key
  // config.value.proxySelected = diskSelected.value
  if (custom) {
    diskCustomIsOpen.value = open
    return
  }
  if (key === "custom") {
    // diskCustom.value = diskCustom.value.trim()
    console.log(`proxySelectedUpdate custokey [${key}] value [${diskCustom.value}]`)
    // if (diskCustom.value === "") {
    //   proxyCustom.value = "http://127.0.0.1:1080"
    // }
    setTimeout(() => {
      diskCustomIsOpen.value = open
    }, 500)
  } else {
    setTimeout(() => {
      diskCustomIsOpen.value = false
    }, 500)
  }
  // config.value.proxyCustom = proxyCustom.value
  // config.value = saveConfig(config.value)
  // console.log('proxySelectedUpdate save', config.value)
  // reGetConfig()
}

onBeforeRouteLeave((to, from, next) => {
  // 判断数据是否修改
  const shouldSave = window.confirm('是否保存修改？');
  if (shouldSave) {
    // 执行保存操作
  }
  next();
});
</script>

<template>
  <div class="page-container">
    <div class="page">
      <header class="header">
        <h1 class="md:text-xl">{{ t("emulator") + ' ' + t('config') }}</h1>
        <div class="flex flex-auto items-center justify-end">
          <div class="text-shadow-primary text-primary-600 cursor-pointer text-sm">
            <div @click="openConfig">{{ t('emulator') + t("configFile") }}</div>
          </div>
        </div>
      </header>
      <div class="card settings-card">
        <div class="flex w-full items-center justify-between py-3 px-8 md:w-1/2">
          <span class="label font-bold">{{ t('id') }}</span>
          <div class="button-select">
            <div class="tips">{{ newAvdId }}</div> <!-- TODO 添加间隔 添加更新方法-->
            <button :class="{ 'button-select-options': true, 'actived': true }"
                    @click="newAvdId='Android_'+String(Math.floor(Math.random() * 1000) + 1000)">
              {{ t('clickRefresh') }}
            </button>
          </div>
        </div>
        <div class="flex w-full items-center justify-between py-3 px-8 md:w-1/2">
          <span class="label font-bold">{{ t('name') }}</span>
          <div class="button-select">
            <input :placeholder='displayName' v-model=displayName
                   :style="{ width: displayName.length*10 +100 + 'px',textAlign:'center',border:'1px solid #e4eaef' }"
                   @input="displayName=displayName.trim()">
            <!-- TODO 这个动态样式为什么不生效 -->
            <!-- TODO 动态更新长度 -->
          </div>
        </div>
        <div class="flex flex-wrap">
          <div class="flex w-full items-center justify-between py-3 px-8 md:w-1/2">
            <span class="label font-bold">{{ t('memory') }}</span>
            <div class="button-select">
              <button v-for="item in Default.memorySelectedOptions"
                      :key="item.key"
                      :value="item.key"
                      :class="{ 'button-select-options': true, 'actived': memorySelected === item.key }"
                      @click="memorySelectedUpdate(item.key,!memoryCustomIsOpen,item.key==='4')">
                {{ item.text }}
              </button>
              <input class="Selected" type="text"
                     v-model="memoryCustom"
                     v-show="memoryCustomIsOpen"
                     @blur="memorySelectedUpdate('custom',false,false)"
                     @keydown.enter="memorySelectedUpdate('4',false,false)"
                     placeholder="4G"
                     @input="memoryCustom=memoryCustom.replace(/\D/g, '');"
                     style="margin-left: 5px;width: 50px;text-align:right;border:1px solid #e4eaef">
              <div class="tips" v-show="memoryCustomIsOpen">G</div>
            </div>
          </div>
        </div>
        <div class="flex w-full items-center justify-between py-3 px-8 md:w-1/2">
          <span class="label font-bold">{{ t('disk') }}</span>
          <div class="button-select">
            <button v-for="item in Default.diskSelectedOptions"
                    :key="item.key"
                    :value="item.key"
                    :class="{ 'button-select-options': true, 'actived': diskSelected === item.key }"
                    @click="diskSelectedUpdate(item.key,!diskCustomIsOpen,item.key==='4')">
              {{ item.text }}
            </button>
            <input class="Selected" type="text"
                   v-model="diskCustom"
                   v-show="diskCustomIsOpen"
                   @blur="diskSelectedUpdate('custom',false,false)"
                   @keydown.enter="diskSelectedUpdate('4',false,false)"
                   placeholder="16G"
                   @input="diskCustom=diskCustom.replace(/\D/g, '');"
                   style="margin-left: 5px;width: 50px;text-align:right;border:1px solid #e4eaef">
            <div class="tips" v-show="diskCustomIsOpen">G</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.header {
  margin: 10px 0;
  width: 100%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  user-select: none
}

.header > h1 {
  flex-shrink: 0;
  font-size: 24px;
  color: #2c8af8;
  font-weight: 500;
  text-shadow: 0 2px 6px rgba(44, 138, 248, .4);
  line-height: 32px
}

.switch {
  display: inline-block;
  width: 32px;
  height: 16px;
  border-radius: 8px;
  background-color: #d8dee2;
  transition: background-color .3s ease;
  position: relative;
  cursor: pointer
}

.switch.checked {
  background-color: #57befc
}

.switch.checked:after {
  transform: translate(16px)
}

.switch:after {
  content: "";
  position: absolute;
  top: -1px;
  height: 18px;
  width: 18px;
  border-radius: 9px;
  background-color: #fff;
  box-shadow: 0 0 8px #2c8af866;
  transition: transform .3s ease;
  transform: translate(-2px)
}

.switch-icon {
  position: absolute;
  transform: translate(-1px) scale(.4);
  color: #fff;
  line-height: 16px
}

.card {
  padding: 15px;
  box-shadow: 2px 5px 20px -3px #2c8af82e;
  background-color: #fff;
  border-radius: 4px
}

.button-select {
  display: flex;
  flex-direction: row
}

.button-select .button-select-options {
  height: 30px;
  padding: 0 15px;
  color: #54759a;
  font-size: 12px;
  line-height: 30px;
  background: #fff;
  border: 1px solid #e4eaef;
  transition: all .3s ease;
  cursor: pointer;
  outline: 0;
  display: block
}

.button-select .button-select-options:hover {
  border: #FF6900 1px solid;
}

.button-select .button-select-options:first-child {
  border-radius: 3px 0 0 3px
}

.button-select .button-select-options:last-child {
  border-radius: 0 3px 3px 0;
  border-right: 1px solid #e4eaef
}

.button-select .button-select-options.actived {
  background: #57befc;
  color: #fff;
  border-color: #57befc;
  box-shadow: 0 2px 5px #57befc80
}

.button-select .button-select-options.actived:active {
  box-shadow: none
}

.button-select > input {
  background: #ffffff;
}

.button-select .tips {
  height: 30px;
  padding: 0 5px;
  color: #54759a;
  line-height: 30px;
  background: #fff;
  transition: all .3s ease;
  cursor: pointer;
  outline: 0;
  display: block;
  align-items: center;
  justify-content: center;
}

.button-select > input:hover {
  border: #FF6900 1px solid;
}

.input {
  display: inline-block;
  height: 30px;
  width: 100%;
  padding: 0 10px;
  font-size: 14px;
  color: #54759a;
  border-radius: 3px;
  border: 1px solid #e4eaef;
  transition: all .3s;
  transition-property: border-color, color, box-shadow
}

.input:focus {
  outline: 0;
  border-color: #57befc;
  color: #2c8af8;
  box-shadow: 0 2px 5px #57befc80
}

@keyframes spinner {
  0% {
    transform: rotate(0)
  }

  to {
    transform: rotate(360deg)
  }
}

.settings-card {
  margin-top: 10px;
  padding: .75rem 0
}

.settings-card .label {
  font-size: 14px;
  color: #54759a
}

.settings-card .external-controller {
  font-size: 14px;
  color: #54759a;
  display: flex;
  justify-content: flex-end;
  font-weight: 400;
  line-height: 17px
}

*, * :before, * :after {
  margin: 0;
  padding: 0;
  box-sizing: inherit
}

.page-container {
  width: 100%;
  height: 100vh;
  padding-left: 10px;
  overflow-y: scroll
}

.page {
  padding: 20px 35px 30px 20px;
  width: 100%;
  min-height: 100vh;
  margin: 0 auto;
  display: flex;
  flex-direction: column
}

input {
  -webkit-appearance: none
}

@media (max-width: 768px) {

  .page-container {
    width: 100%;
    padding: 0 10px;
    height: calc(100vh - 60px);
    -webkit-overflow-scrolling: touch
  }

  .page-container::-webkit-scrollbar {
    display: none
  }

  .page {
    padding: 0 0 20px;
    height: 100%;
    min-height: unset
  }
}

@font-face {
  font-family: clash-iconfont;
  src: url(//at.alicdn.com/t/font_841708_ok9czskbhel.ttf?t=1576162884356) format("truetype")
}

.clash-iconfont {
  font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, Noto Sans, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", Segoe UI Symbol, "Noto Color Emoji";
  font-size: 14px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c8af8
}

.icon-check:before {
  content: "\e606"
}

button, input {
  font-family: inherit;
  font-size: 100%;
  line-height: 1.15;
  margin: 0;
  padding: 0;
  line-height: inherit;
  color: inherit
}

button {
  text-transform: none;
  background-color: transparent;
  background-image: none
}

button, [type=button] {
  -webkit-appearance: button
}

button {
  cursor: pointer
}

h1 {
  font-size: inherit;
  font-weight: inherit
}

input::placeholder {
  opacity: 1;
  color: #9ca3af
}


input::-moz-placeholder {
  opacity: 1;
  color: #9ca3af
}

input:-ms-input-placeholder {
  opacity: 1;
  color: #9ca3af
}

input::-ms-input-placeholder {
  opacity: 1;
  color: #9ca3af
}

h1 {
  margin: 0
}

.flex {
  display: -webkit-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex
}

.flex-wrap {
  -ms-flex-wrap: wrap;
  -webkit-flex-wrap: wrap;
  flex-wrap: wrap
}

.items-center {
  -webkit-box-align: center;
  -ms-flex-align: center;
  -webkit-align-items: center;
  align-items: center
}

.justify-end {
  -webkit-box-pack: end;
  -ms-flex-pack: end;
  -webkit-justify-content: flex-end;
  justify-content: flex-end
}

.justify-between {
  -webkit-box-pack: justify;
  -ms-flex-pack: justify;
  -webkit-justify-content: space-between;
  justify-content: space-between
}

.flex-auto {
  -webkit-box-flex: 1;
  -ms-flex: 1 1 auto;
  -webkit-flex: 1 1 auto;
  flex: 1 1 auto
}

.font-bold {
  font-weight: 700
}

.py-3 {
  padding-top: .75rem;
  padding-bottom: .75rem
}

.px-8 {
  padding-left: 2rem;
  padding-right: 2rem
}

.text-center {
  text-align: center
}

.w-full {
  width: 100%
}

.w-28 {
  width: 7rem
}

.Selected {
  background-color: #57befc;
  color: #fff;
  border: #e5e7eb 1px solid;
  border-radius: 3px;
  padding: 0 7px;
  height: 30px;
  color: #54759a;
  line-height: 30px;
  font-size: 14px;
  cursor: pointer;
  transition: all .15s ease
}

input:focus {
  outline: #2c8af8 1px solid;
}

.text-shadow-primary {
  text-shadow: 0 0 6px rgb(44 138 248 / 40%);
}

.text-primary-600 {
  color: rgba(44, 138, 248, var(--tw-text-opacity));
  --tw-text-opacity: 1;
}

.cursor-pointer {
  cursor: pointer;
}

.text-sm {
  font-size: .875rem;
  line-height: 1.25rem;
}

.checkbox {
  position: relative;
  display: flex;
  padding-left: 26px;
  line-height: 18px;
  cursor: pointer;
}

.checkbox:before {
  position: absolute;
  top: 50%;
  left: 0;
  display: inline-block;
  width: 18px;
  height: 18px;
  border: 1px solid #e4eaef;
  border-radius: 3px;
  background-color: #fff;
  content: "";
  transition: background-color .3s ease;
  transform: translateY(-9px);
}
</style>