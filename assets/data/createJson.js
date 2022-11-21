const fs = require('fs');
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

console.log(jsonList);
console.log(JSON.stringify(jsonList));
console.log(idx);
let dataJson = JSON.stringify(jsonList);

fs.writeFileSync('org_data.json', dataJson);






