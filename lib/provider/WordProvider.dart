import 'package:flutter/material.dart';

import '../util/structure.dart';

class WordProvider extends ChangeNotifier {
  List<dynamic> _correctWordList = [];
  List<CreatedSingleWordType> _clickedSingleWords = [];
  int _singleWordCount = 4;
  bool isCorrect = false;

  int getSingleWordCnt() => _singleWordCount;
  void setSingleWordCnt(cnt) => _singleWordCount = cnt;
  void setCorrectWordList(list) => _correctWordList = list;

  String getClickedWordsString() {
    if (_clickedSingleWords.isEmpty) return '';
    return _clickedSingleWords.map((_) => _.getWord()).join("");
  }

  void wordClick(CreatedSingleWordType wordObj) {
    if (isAlreadyExists(wordObj)) {
      // 이미 클릭된 단어 빼기
      _clickedSingleWords.removeWhere((ele) => ele == wordObj);
    } else {
      // 클릭된 단어 추가하기
      _clickedSingleWords.add(wordObj);
    }

    if (_singleWordCount == _clickedSingleWords.length) {
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

  bool isAlreadyExists(CreatedSingleWordType newWordObj) {
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      if (clickedWord == newWordObj) return true;
    }
    return false;
  }

  bool checkCorrect() {
    String clickedWord = getClickedWordsString();
    return _correctWordList.contains(clickedWord);
  }

  // instance 기준으로 동일 여부 판단 (=> single word가 같더라도, 다른 instance로 판단함)
  bool _checkCorrect() {
    bool isCorrect = true;
    // late int firstId;
    // for (int i = 0; i < _clickedWords.length; i++) {
    //   CreatedWordType clickedWord = _clickedWords[i];
    //   EqaulType equalObj = clickedWord.getEqualObj();
    //
    //   if (i == 0) firstId = equalObj.getId();
    //
    //   // 동일한 단어가 아닐경우,
    //   if (firstId != equalObj.getId()) {
    //     isCorrect = false;
    //     break;
    //   }
    //
    //   // 단어의 순서가 맞지 않을 경우,
    //   if (i != equalObj.getSq()) {
    //     isCorrect = false;
    //     break;
    //   }
    // }
    return isCorrect;
  }

  void clean() {
    _clickedSingleWords = [];
  }

  void correctFn() {
    print('맞춤');
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      clickedWord.setIsCorrect(true);
    }
  }

  void inCorrectFn() {
    print('못맞춤');
    for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
      clickedWord.setIsClick(false);
    }
  }
}
