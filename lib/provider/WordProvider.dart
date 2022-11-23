import 'package:flutter/material.dart';

import '../util/structure.dart';

class WordProvider extends ChangeNotifier {
  List<dynamic> _correctWordList = [];
  List<CreatedSingleWordType> _singleWordObjInstanceList = [];
  List<CreatedSingleWordType> _clickedSingleWords = [];

  int _singleWordCount = 4;
  int _correctCnt = 0;
  bool isWordCorrect = false;
  bool isAllCorrect = false;

  int getSingleWordCnt() => _singleWordCount;
  String getClickedWordsString() {
    if (_clickedSingleWords.isEmpty) return '';
    return _clickedSingleWords.map((_) => _.getWord()).join("");
  }

  void setSingleWordCnt(int cnt) => _singleWordCount = cnt;
  void setCorrectWordList(List<dynamic> list) {
    print(list);
    _correctWordList = list;
  }

  void wordClick(CreatedSingleWordType wordObj) {
    if (isAlreadyClicked(wordObj)) {
      // 이미 클릭된 단어 빼기
      _clickedSingleWords.removeWhere((ele) => ele == wordObj);
    } else {
      // 클릭된 단어 추가하기
      _clickedSingleWords.add(wordObj);
    }

    if (_singleWordCount == _clickedSingleWords.length) {
      if (checkWordCorrect()) {
        correctFn();
      } else {
        inCorrectFn();
      }
      clean();
    }

    notifyListeners();
  }

  bool isAlreadyClicked(CreatedSingleWordType newWordObj) {
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      if (clickedWord == newWordObj) return true;
    }
    return false;
  }

  bool checkWordCorrect() {
    String clickedWord = getClickedWordsString();
    print(_correctWordList);
    print(clickedWord);
    return _correctWordList.contains(clickedWord);
  }

  void clean() {
    _clickedSingleWords = [];
  }

  void correctFn() {
    print('맞춤');
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      clickedWord.setIsCorrect(true);
    }
    _correctCnt++;
    if (_correctCnt == _correctWordList.length) {
      isAllCorrect = true;
    }
  }

  void inCorrectFn() {
    print('못맞춤');
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      clickedWord.setIsClick(false);
    }
  }

  void retry() {
    _clickedSingleWords = [];

    _correctCnt = 0;
    isWordCorrect = false;
    isAllCorrect = false;
    for (CreatedSingleWordType singleWordObjInstance
        in _singleWordObjInstanceList) {
      singleWordObjInstance.setIsCorrect(false);
      singleWordObjInstance.setIsClick(false);
    }
  }

  void nextLevel() {
    _clickedSingleWords = [];

    _correctCnt = 0;
    isWordCorrect = false;
    isAllCorrect = false;
  }

  void setSingleWordObjList(List<CreatedSingleWordType> singleWordObjList) {
    _singleWordObjInstanceList = singleWordObjList;
  }
}
