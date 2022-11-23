import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:real_word/util/structure.dart';
import 'package:real_word/widget/CustomColumn.dart';
import 'package:real_word/widget/CustomRow.dart';

class Util {
  Future<List<dynamic>> getWordFromJson(
    String keyName, [
    int wordCount = 4,
  ]) async {
    final String jsonString = await rootBundle.loadString('data/org_data.json');
    Map<String, dynamic> orgJson = jsonDecode(jsonString);

    List<dynamic> dataJson = orgJson[keyName];
    List<dynamic> resultDataList = getRandomDataList(dataJson, wordCount);
    return resultDataList;
  }

  Future<List<String>> getWordKeyFromJson() async {
    final String jsonString =
        await rootBundle.loadString('data/org_data_key_list.json');
    List<String> orgJson =
        (jsonDecode(jsonString) as List<dynamic>).cast<String>();

    return orgJson;
  }

  List<dynamic> getRandomDataList(List<dynamic> dataJson, int wordCount) {
    int dataLen = dataJson.length;
    if (dataLen < wordCount) return []; // 가지고 오려는 수보다 데이터 수가 적을 떄

    List<dynamic> resultDataList = [];
    Function getRandom = getRandomIdx(dataLen);
    for (int i = 0; i < wordCount; i++) {
      int rndIdx = getRandom();
      resultDataList.add(dataJson[rndIdx]);
    }
    return resultDataList;
  }

  Function getRandomIdx(int dataLen) {
    List<int> existsIdx = [];
    int rndIdx;

    return () {
      while (true) {
        rndIdx = Random().nextInt(dataLen);
        if (existsIdx.contains(rndIdx)) {
          continue;
        } else {
          existsIdx.add(rndIdx);
          break;
        }
      }
      return rndIdx;
    };
  }

  List<CreatedSingleWordType> createSingleWord(List<dynamic> orgWordJson) {
    List<CreatedSingleWordType> wordObjList = [];

    for (int i = 0; i < orgWordJson.length; i++) {
      String word = orgWordJson[i];
      for (int j = 0; j < word.split('').length; j++) {
        wordObjList.add(CreatedSingleWordType().add(word[j], i, j));
      }
    }
    return wordObjList;
  }

  List<CustomRow> renderText(
    List<CreatedSingleWordType> wordObjList,
    int columnCnt,
  ) {
    List<CustomRow> rowWidget = [];
    List<CustomColumn> columnWidget = [];
    for (int i = 0; i < wordObjList.length; i++) {
      if (i % columnCnt == 0) {
        rowWidget.add(CustomRow(column: columnWidget));
        columnWidget = [];
      }
      columnWidget.add(CustomColumn(word: wordObjList[i]));
    }
    rowWidget.add(CustomRow(column: columnWidget));
    return rowWidget;
  }

  void shuffle(List elements, [int start = 0, int? end, Random? random]) {
    random ??= Random();
    end ??= elements.length;
    var length = end - start;
    while (length > 1) {
      var pos = random.nextInt(length);
      length--;
      var tmp1 = elements[start + pos];
      elements[start + pos] = elements[start + length];
      elements[start + length] = tmp1;
    }
  }
}
