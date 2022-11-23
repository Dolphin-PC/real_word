const fs = require('fs');
const data = fs.readFileSync('./org_data.json', 'utf-8');

const json_data = JSON.parse(data);
// console.log(json_data);

const json_key_list = Object.keys(json_data);



// orginal key
function exportJsonKey() {
    const jsonToText = JSON.stringify(json_key_list);

    fs.writeFileSync('org_data_key_list.json', jsonToText);
};

// only key number
function exportJsonKeyNumber() {
    let resultArray = [];
    for (const json_key of json_key_list) {
        const [key, number] = json_key.split("_");

        if (number < 3) continue;
        resultArray.push(number);
    }
    resultArray.sort((a, b) => a - b);
    console.log(resultArray);

    fs.writeFileSync('org_data_key_list.json', JSON.stringify(resultArray));
};

exportJsonKeyNumber();
