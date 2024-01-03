import {xml2json} from "xml-js";
import * as fs from "fs";
import * as https from "https";
import {join} from "path";

const google_main_site = "https://dl.google.com/android/repository/";
let config_path = join(__dirname, "../config.json");
let main_xml_json: any;
let main_xml_status = false;
let system_image_default_xml_url = "";
let system_image_default_xml_json = {};
let system_image_default_xml_status = false;
let system_image_google_apis_xml_url = "";
let system_image_google_apis_xml_json = {};
let system_image_google_apis_xml_status = false;
let system_image_google_apis_playstore_xml_url = "";
let system_image_google_apis_playstore_xml_json = {};
let system_image_google_apis_playstore_xml_status = false;
let getDefaultSystemImageURLStatus = false;
let getGoogleApisSystemImageURLStatus = false;
let getGoogleApisPlayStoreSystemImageURLStatus = false;
let writeConfigStatus = false;
let writeShellStatus = false;
let configJsons = JSON.parse(fs.readFileSync(config_path, "utf8")) || {};
configJsons["system-images"] ??= {
    "22": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "23": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "25": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "27": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "28": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "29": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "30": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "32": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "33": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    },
    "34": {
        default: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis: {
            x86_64: {},
            "arm64-v8a": {}
        },
        google_apis_playstore: {
            x86_64: {},
            "arm64-v8a": {}
        }
    }
};
configJsons.languageSelected ??= "auto";
configJsons.proxySelected ??= "none";
configJsons.githubSelected ??= "none";
configJsons.githubCustom ??= "https://ghproxy.com";
configJsons.proxyCustom ??= "http://127.0.0.1:7890";

console.log('\x1Bc\n\n\n\n\n');

function sendHttpRequest(url: string, function_name: string, callback: any) {
    console.log(`${function_name} doing`);
    https
        .get(google_main_site + url, (response) => {
            if (response.statusCode !== 200) {
                console.trace(`${function_name} statusCode: ${response.statusCode}`);
            }
            let responseBody = "";
            response.on("data", (chunk) => {
                responseBody += chunk;
            });

            response.on("end", () => {
                if (responseBody === "") {
                    console.trace(`${function_name} responseBody: ${responseBody}`);
                }
                const tmp_json = xml2json(responseBody, {compact: true, spaces: 4});
                if (tmp_json === "{}") {
                    console.trace(`${function_name} xml2json: ${tmp_json}`);
                }
                console.log(`${function_name} done`);
                callback(JSON.parse(tmp_json), true);
            });
        })
        .on("error", (error) => {
            console.trace(`${function_name} Error: ${error.message}`);
        });
}

function initMainXml() {
    const tmp_dir = "tmp";
    if (!fs.existsSync(tmp_dir)) {
        console.log(fs.mkdirSync(tmp_dir, {recursive: true}));
        console.log("Directory created successfully.");
    } else {
        console.log("Directory already exists.");
    }

    sendHttpRequest(
        "addons_list-5.xml",
        "initMainXml",
        (modified_json: Object, modified_status: boolean) => {
            main_xml_json = modified_json;
            main_xml_status = modified_status;
        }
    );
}

function getSystemImageXML() {
    (async () => {
        while (!main_xml_status) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("getSystemImageXML doing");
        let sites = main_xml_json["common:site-list"]["site"];
        if (sites.length === undefined || !sites) {
            console.trace(`getSystemImage sites: ${sites}`);
        }
        for (let i = 0; i < sites.length; i++) {
            let site_displayName = sites[i]["displayName"]["_text"];
            if (site_displayName === "Android System Images") {
                console.log("default url", google_main_site + sites[i]["url"]["_text"]);
                system_image_default_xml_url = sites[i]["url"]["_text"];
            }
            if (site_displayName === "Google API add-on System Images") {
                console.log(
                    "google_apis url",
                    google_main_site + sites[i]["url"]["_text"]
                );
                system_image_google_apis_xml_url = sites[i]["url"]["_text"];
            }
            if (site_displayName === "Google API with Playstore System Images") {
                console.log(
                    "google_apis_playstore url",
                    google_main_site + sites[i]["url"]["_text"]
                );
                system_image_google_apis_playstore_xml_url = sites[i]["url"]["_text"];
            }
        }
        if (!system_image_default_xml_url || system_image_default_xml_url === "") {
            console.trace(
                `getSystemImage default url: ${system_image_default_xml_url}`
            );
        }
        if (
            !system_image_google_apis_xml_url ||
            system_image_google_apis_xml_url === ""
        ) {
            console.trace(
                `getSystemImage google_apis url: ${system_image_google_apis_xml_url}`
            );
        }
        if (
            !system_image_google_apis_playstore_xml_url ||
            system_image_google_apis_playstore_xml_url === ""
        ) {
            console.trace(
                `getSystemImage google_apis_playstore url: ${system_image_google_apis_playstore_xml_url}`
            );
        }
        sendHttpRequest(
            system_image_default_xml_url,
            "getSystemImageXML default",
            (modified_json: Object, modified_status: boolean) => {
                system_image_default_xml_json = modified_json;
                system_image_default_xml_status = modified_status;
            }
        );
        sendHttpRequest(
            system_image_google_apis_xml_url,
            "getSystemImageXML google_apis",
            (modified_json: Object, modified_status: boolean) => {
                system_image_google_apis_xml_json = modified_json;
                system_image_google_apis_xml_status = modified_status;
            }
        );
        sendHttpRequest(
            system_image_google_apis_playstore_xml_url,
            "getSystemImageXML google_apis_playstore",
            (modified_json: Object, modified_status: boolean) => {
                system_image_google_apis_playstore_xml_json = modified_json;
                system_image_google_apis_playstore_xml_status = modified_status;
            }
        );
    })();
}

function getSystemImageURL() {
    (async () => {
        while (!system_image_default_xml_status) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("getSystemImage default doing");
        let sites =
            system_image_default_xml_json["sys-img:sdk-sys-img"]["remotePackage"];
        if (sites.length === undefined || !sites) {
            console.trace(`getSystemImageURL default sites: ${sites}`);
        }
        for (let i = 0; i < sites.length; i++) {
            let api_level = sites[i]["type-details"]["api-level"]["_text"];
            let abi = sites[i]["type-details"]["abi"]["_text"];

            if (abi !== "x86_64" && abi !== "arm64-v8a") {
                continue;
            }
            if (sites[i]["type-details"]["codename"]) {
                continue;
            }
            if (!configJsons["system-images"][api_level]) {
                continue;
            }
            let os_args = sites[i]["archives"]["archive"];
            configJsons["system-images"][api_level]["default"][abi]["path"] = (sites[
                i
                ]["_attributes"]["path"] ||= "异常路径").replace(/;/g, '/');
            if (os_args instanceof Array) {
                Object.values(os_args).forEach((value) => {
                    configJsons["system-images"][api_level]["default"][abi][
                        value["host-os"]["_text"]
                        ] =
                        google_main_site +
                        "sys-img/android/" +
                        value["complete"]["url"]["_text"];
                });
            } else if (os_args instanceof Object) {
                configJsons["system-images"][api_level]["default"][abi]["custom"] =
                    google_main_site +
                    "sys-img/android/" +
                    os_args["complete"]["url"]["_text"];
            } else {
                console.log(`getSystemImageURL default typeErr: ${os_args}`);
            }
        }
        getDefaultSystemImageURLStatus = true;
        console.log("getSystemImage default done");
    })();
    (async () => {
        while (!system_image_google_apis_xml_status) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("getSystemImage google_apis doing");
        let sites = system_image_google_apis_xml_json["sys-img:sdk-sys-img"]["remotePackage"];
        if (sites.length === undefined || !sites) {
            console.trace(`getSystemImageURL google_apis sites: ${sites}`);
        }
        for (let i = 0; i < sites.length; i++) {
            let api_level = sites[i]["type-details"]["api-level"]["_text"];
            let abi = sites[i]["type-details"]["abi"]["_text"];
            if (abi !== "x86_64" && abi !== "arm64-v8a") {
                continue;
            }
            if (sites[i]["type-details"]["codename"]) {
                continue;
            }
            if (!configJsons["system-images"][api_level]) {
                continue;
            }
            let os_args = sites[i]["archives"]["archive"];
            configJsons["system-images"][api_level]["google_apis"][abi]["path"] =
                (sites[i]["_attributes"]["path"] ||= "异常路径").replace(/;/g, '/');
            if (os_args instanceof Array) {
                Object.values(os_args).forEach((value) => {
                    configJsons["system-images"][api_level]["google_apis"][abi][
                        value["host-os"]["_text"]
                        ] =
                        google_main_site +
                        "sys-img/google_apis/" +
                        value["complete"]["url"]["_text"];
                });
            } else if (os_args instanceof Object) {
                configJsons["system-images"][api_level]["google_apis"][abi]["custom"] =
                    google_main_site +
                    "sys-img/google_apis/" +
                    os_args["complete"]["url"]["_text"];
            } else {
                console.log(`getSystemImageURL google_apis typeErr: ${os_args}`);
            }
        }
        getGoogleApisSystemImageURLStatus = true;
        console.log("getSystemImage google_apis done");
    })();
    (async () => {
        while (!system_image_google_apis_playstore_xml_status) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("getSystemImage google_apis_playstore doing");
        let sites =
            system_image_google_apis_playstore_xml_json["sys-img:sdk-sys-img"][
                "remotePackage"
                ];
        if (sites.length === undefined || !sites) {
            console.trace(`getSystemImageURL google_apis_playstore sites: ${sites}`);
        }
        for (let i = 0; i < sites.length; i++) {
            let api_level = sites[i]["type-details"]["api-level"]["_text"];
            let abi = sites[i]["type-details"]["abi"]["_text"];
            if (abi !== "x86_64" && abi !== "arm64-v8a") {
                continue;
            }
            if (sites[i]["type-details"]["codename"]) {
                console.log(
                    "google_apis_playstore",
                    api_level,
                    sites[i]["type-details"]["codename"]["_text"],
                    "not paired"
                );
                continue;
            }

            if (!configJsons["system-images"][api_level]) {
                continue;
            }
            let os_args = sites[i]["archives"]["archive"];
            configJsons["system-images"][api_level]["google_apis_playstore"][abi][
                "path"
                ] = (sites[i]["_attributes"]["path"] ||= "异常路径").replace(/;/g, '/');
            if (os_args instanceof Array) {
                Object.values(os_args).forEach((value) => {
                    configJsons["system-images"][api_level]["google_apis_playstore"][abi][
                        value["host-os"]["_text"]
                        ] =
                        google_main_site +
                        "sys-img/google_apis_playstore/" +
                        value["complete"]["url"]["_text"];
                });
            } else if (os_args instanceof Object) {
                configJsons["system-images"][api_level]["google_apis_playstore"][abi][
                    "custom"
                    ] =
                    google_main_site +
                    "sys-img/google_apis_playstore/" +
                    os_args["complete"]["url"]["_text"];
            } else {
                console.log(
                    `getSystemImageURL google_apis_playstore typeErr: ${os_args}`
                );
            }
            getGoogleApisPlayStoreSystemImageURLStatus = true;
        }
        console.log("getSystemImage google_apis_playstore done");
    })();
}

function writeConfig() {
    (async () => {
        while (
            !getDefaultSystemImageURLStatus &&
            !getGoogleApisSystemImageURLStatus &&
            !getGoogleApisPlayStoreSystemImageURLStatus
            ) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("writeConfig doing");
        fs.writeFileSync(config_path, JSON.stringify(configJsons), "utf8");
        writeConfigStatus = true;
        console.log("writeConfig done");
    })();
}

function writeShell() {
    (async () => {
        while (!writeConfigStatus) {
            await new Promise((resolve) => setTimeout(resolve, 500)); // 延时1秒
        }
        console.log("writeShell doing");
        const androidLevelMap = {
            "22": "5",
            "23": "6",
            "25": "7",
            "27": "8",
            "28": "9",
            "29": "10",
            "30": "11",
            "32": "12",
            "33": "13",
            "34": "14"
        }
        let option_string = "options=("
        Object.values(androidLevelMap).forEach((value) => {
            option_string += `"Android ${value}" "Android ${value} Google" `
        })

        console.log(option_string + '"Quit")')

        console.log('case $opt in')
        const systemImages = configJsons["system-images"];
        Object.keys(systemImages).forEach((value) => {
            console.log(`"Android ${androidLevelMap[value]}")`)
            console.log(`    system_images=Android${androidLevelMap[value]}`)
            console.log(`    system_images_url="${systemImages[value]["default"]["arm64-v8a"]["custom"]}"`)
            console.log(`    system_images_path="${systemImages[value]["default"]["arm64-v8a"]["path"]}"`)
            console.log(`    ;;`)
            console.log(`"Android ${androidLevelMap[value]} Google")`)
            console.log(`    system_images=Android${androidLevelMap[value]}_google`)
            console.log(`    system_images_url="${systemImages[value]["google_apis_playstore"]["arm64-v8a"]["custom"] ?? systemImages[value]["google_apis_playstore"]["arm64-v8a"]["macosx"] ?? systemImages[value]["google_apis"]["arm64-v8a"]["custom"] ?? "链接异常"}"`)
            console.log(`    system_images_path="${systemImages[value]["google_apis_playstore"]["arm64-v8a"]["path"] ?? systemImages[value]["google_apis"]["arm64-v8a"]["path"] ?? "异常路径"}"`)
            console.log(`    ;;`)
        })
        console.log('"Quit")')
        console.log('    exit 0')
        console.log('    ;;')
        console.log('*)')
        console.log('    echo "Invalid option"')
        console.log('    exit 0')
        console.log('    ;;')
        console.log('esac')
        writeShellStatus = true;
        console.log("writeShell done");
    })();
}


initMainXml()
getSystemImageXML()
getSystemImageURL()
writeConfig()
writeShell()