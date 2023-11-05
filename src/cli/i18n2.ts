const en_US =require("../../public/locales/en-US.json")
const zh_CN =require("../../public/locales/zh-CN.json")
export const APP_LANG = process.env.APP_LANG || 'en-US';

export  const t1 = function  (v:string):string {
    if(APP_LANG==='zh-CN'){
        return en_US["custom"]
    }
    return zh_CN["custom"]
}