import 'package:flutter/material.dart';

import '../util/structure.dart';

class WordProvider extends ChangeNotifier {
  List<CreatedWordType> _clickedWords = [];
  int _wordCount = 4;
  bool isCorrect = false;

  int getWordCnt() => _wordCount;
  void setWordCnt(cnt) => _wordCount = cnt;

  String getClickedWordsString() {
    if (_clickedWords.isEmpty) return '';
    return _clickedWords.map((_) => _.getWord()).join("");
  }

  void wordClick(CreatedWordType wordObj) {
    if (isAlreadyExists(wordObj)) {
      // 이미 클릭된 단어 빼기
      _clickedWords.removeWhere((ele) => ele == wordObj);
    } else {
      // 클릭된 단어 추가하기
      _clickedWords.add(wordObj);
    }

    if (_wordCount == _clickedWords.length) {
      isCorrect = checkCorrect();

      if (isCorrect) {
        correctFn();
      } else {
        inCorrectFn();
      }
      clean();
    }

    notifyListeners();
  }

  bool isAlreadyExists(CreatedWordType newWordObj) {
    for (CreatedWordType clickedWord in _clickedWords) {
      if (clickedWord == newWordObj) return true;
    }
    return false;
  }

  bool checkCorrect() {
    bool isCorrect = true;
    late int firstId;
    for (int i = 0; i < _clickedWords.length; i++) {
      CreatedWordType clickedWord = _clickedWords[i];
      EqaulType equalObj = clickedWord.getEqualObj();

      if (i == 0) firstId = equalObj.getId();

      // 동일한 단어가 아닐경우,
      if (firstId != equalObj.getId()) {
        isCorrect = false;
        break;
      }

      // 단어의 순서가 맞지 않을 경우,
      if (i != equalObj.getSq()) {
        isCorrect = false;
        break;
      }
    }

    return isCorrect;
  }

  void clean() {
    _clickedWords = [];
  }

  void correctFn() {
    print('맞춤');
    for (CreatedWordType clickedWord in _clickedWords) {
      clickedWord.setIsCorrect(true);
    }
  }

  void inCorrectFn() {
    print('못맞춤');
    for (CreatedWordType clickedWord in _clickedWords) {
      clickedWord.setIsClick(false);
    }
  }
}
