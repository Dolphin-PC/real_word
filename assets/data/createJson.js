const fs = require('fs');


function _() {
    const data = fs.readFileSync('./org_data.txt', 'utf-8');

    const dataList = data.split('\n');

    let jsonList = {};

    let idx = 0;
    for (let data of dataList) {
        let _key = `key_${data.length}`;
        if (jsonList[_key] == undefined) {
            jsonList[_key] = [];
        }
        jsonList[_key].push(data);
        idx++;
    }

    return jsonList;
}

function export_org_json(jsonList) {
    let dataJson = JSON.stringify(jsonList);

    fs.writeFileSync('org_data.json', dataJson);
}

function export_3_20_json(org_json) {
    let resultObj = {};

    const jsonKeys = Object.keys(org_json);
    for (const json_key of jsonKeys) {
        const [key, number] = json_key.split("_");
        const each_json_key_length = org_json[json_key].length;

        if (each_json_key_length < 20) continue;
        if (number < 3) continue;

        resultObj[json_key] = org_json[json_key];
    }
    fs.writeFileSync('org_data.json', JSON.stringify(resultObj));
}

const org_json = _();

export_3_20_json(org_json);



