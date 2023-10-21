import {accessSync, constants, promises} from "fs";
import path from "path";
import {exec} from "child_process";

async function findAvdFiles(dir: string, depth: number, callback: (filePath: string) => void,): Promise<void> {
    if (depth > 8) {
        return;
    }

    const files = await promises.readdir(dir);

    for (const file of files) {
        if (file.endsWith('.avd')) {
            callback(path.join(dir, file));
        }
    }

    for (const file of files) {
        if (file === '.DS_Store') {
            continue;
        }

        const filePath = path.join(dir, file);

        if (depth > 3 && !filePath.includes('.app')) {
            continue;
        }

        if (file === 'Contents') {
            depth = 5;
        }

        const fileStat = await promises.stat(filePath);

        if (fileStat.isDirectory()) {
            try {
                const linkStat = await promises.lstat(filePath);
                if (linkStat.isSymbolicLink()) {
                    continue;
                }
            } catch (error) {
                continue; // 如果 lstat 报错，说明文件不存在或者无权限访问，直接跳过
            }

            await findAvdFiles(filePath, depth + 1, callback);
        }
    }
}

let logs = ""
let timeLast = new Date();
const childProcess = exec(`find /Applications -name "*.avd" -type d -mindepth 5 -maxdepth 8`)
childProcess.stdout?.on('data', (data: any) => {
    logs = logs.concat(data.toString());
});
childProcess.on('exit', () => {
    logs.split('\n').filter((line: any) => {
        // let name = line.trim().split(/\n/)
        if (line === "") {
            return
        }
        // EXAMPLE /Applications/金铲铲之战.app/Contents/MacOS/avd/Android5_1610.avd
        let display_name = line.split('/').pop().replace('.avd', '')
        line.split('/').filter((item: any) => {
            if (item === "") {
                return
            }
            if (item.includes('.app')) {
                display_name = item.replace('.app', '')
                return
            }
        })
        let avdIcon = path.join(line, '../../../Resources/ApplicationStub.png')
        let execAPP = path.join(line, '../../../MacOS/runemu')
        try {
            accessSync(avdIcon, constants.F_OK);
            avdIcon = "file://" + avdIcon
        } catch (err) {
            avdIcon = "/src/static/icon.png";
        }
    })
    console.log("childProcess 耗时: " + (new Date().getTime() - timeLast.getTime()) + "ms");
});

timeLast = new Date();
let fileLists: string[] = []
findAvdFiles('/Applications', 0, (filePath) => {
    fileLists.push(filePath);
}).then(() => {
    console.log("findAvdFiles 耗时: " + (new Date().getTime() - timeLast.getTime()) + "ms");
    console.log('findAvdFiles:', fileLists)
});