import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:real_word/util/structure.dart';
import 'package:real_word/widget/CustomColumn.dart';
import 'package:real_word/widget/CustomRow.dart';

class Util {
  Future<List<dynamic>> getWordFromJson() async {
    final String jsonString = await rootBundle.loadString('data/tdata.json');
    Map<String, dynamic> orgJson = jsonDecode(jsonString);
    return orgJson['key'];
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
