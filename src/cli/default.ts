import {ref} from "vue";

import {t} from "./i18n";

export const proxySelectedOption = [
    {key: 'none', text: t("none"), value: ""},
    {key: 'clash', text: "Clash", value: "http://127.0.0.1:7890"},
    {key: 'ssr', text: "Shadowsocks", value: "http://127.0.0.1:1080"},
    {key: 'v2ray', text: "V2Ray", value: "http://127.0.0.1:10809"},
    {key: 'custom', text: t("custom"), value: "http://127.0.0.1:10809"}
]
export const githubSelectedOption = [
    {key: 'none', text: t("none"), value: ""},
    {key: 'ghproxy', text: "ghproxy", value: "https://ghproxy.com"},
    {key: 'custom', text: t("custom"), value: "https://ghproxy.com"},
    // TODO t("custom") is not working
]
export const languageOptions = [
    {key: 'zh-CN', text: '中文'},
    {key: 'auto', text: t('auto')},
    {key: 'en-US', text: 'English'}
]
export const memorySelectedOptions = [
    {key: "2", text: '2G'},
    {key: "4", text: '4G'},
    {key: "8", text: '8G'},
    {key: 'custom', text: t("custom"), value: "6G"}
]
export const diskSelectedOptions = [
    {key: "8", text: '8G'},
    {key: "16", text: '16G'},
    {key: "32", text: '32G'},
    {key: 'custom', text: t("custom"), value: "6G"}
]
export const emulatorLists = ref({} as { [key: string]: any })
