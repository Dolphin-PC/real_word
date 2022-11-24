import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_word/util/structure.dart';
import 'package:real_word/widget/CustomColumn.dart';
import 'package:real_word/widget/CustomRow.dart';
import 'package:real_word/widget/WordButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  Future<List<dynamic>> getWordFromJson(String keyName,
      [int wordCount = 4]) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/org_data.json');
    Map<String, dynamic> orgJson = jsonDecode(jsonString);

    List<dynamic> dataJson = orgJson[keyName];
    List<dynamic> resultDataList = getRandomDataList(dataJson, wordCount);
    return resultDataList;
  }

  Future<List<String>> getWordKeyFromJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/org_data_key_list.json');
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

  Widget renderWord(List<CreatedSingleWordType> wordObjList, int columnCnt,
      double screenWidth) {
    Widget renderWrap() {
      List<WordButton> wrapWidget = [];
      for (CreatedSingleWordType word in wordObjList) {
        wrapWidget.add(WordButton(createdWordType: word));
      }

      return Wrap(
        children: wrapWidget,
      );
    }

    Widget renderRow() {
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

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowWidget,
      );
    }

    Widget result;
    if (screenWidth < columnCnt * 70.0) {
      result = renderWrap();
    } else {
      result = renderRow();
    }

    return result;
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

  Future<bool> isSharedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<T?> getSharedData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) return null;

    switch (T) {
      case bool:
        return prefs.getBool(key) as T;
      case String:
        return prefs.getString(key) as T;
      case int:
        return prefs.getInt(key) as T;
      case double:
        return prefs.getDouble(key) as T;
      case List<String>:
        return prefs.getStringList(key) as T;
      case Object:
        return prefs.get(key) as T;
    }
    return null;
  }

  void setSharedData<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    switch (T) {
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
      case List<String>:
        prefs.setStringList(key, value as List<String>);
        break;
    }
  }

  void execAfterOnlyBinding(Function fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fn();
    });
  }
}
