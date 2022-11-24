import 'package:flutter/material.dart';
import 'package:real_word/enum.dart';
import 'package:real_word/util/util.dart';

import '../util/structure.dart';

class WordProvider extends ChangeNotifier {
  Util util = Util();
  List<dynamic> _correctWordList = [];
  List<CreatedSingleWordType> _singleWordObjInstanceList = [];
  List<CreatedSingleWordType> _clickedSingleWords = [];

  int _singleWordCount = 0;
  int _correctCnt = 0;
  bool isWordCorrect = false;
  bool isAllCorrect = false;
  bool _isAlreadyAllCorrect = false;

  int correctScore = 0;

  late double screenWidth;
  GAME_STATUS gameStatus = GAME_STATUS.STOP;

  int getSingleWordCnt() => _singleWordCount;
  void setSingleWordCnt(int cnt) => _singleWordCount = cnt;
  void setScreenWidth(double width) {
    screenWidth = width;
    notifyListeners();
  }

  /* 메인 로직 */
  String getClickedWordsString() {
    if (_clickedSingleWords.isEmpty) return '';
    return _clickedSingleWords.map((_) => _.getWord()).join("");
  }

  void wordClick(CreatedSingleWordType wordObj) {
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
        if (_isAlreadyAllCorrect == false) {
          _isAlreadyAllCorrect = true;
          correctScore += _correctCnt;
          util.setSharedData<int>('score', correctScore);
        }
      }

      notifyListeners();
    }

    void inCorrectFn() {
      print('못맞춤');
      for (CreatedSingleWordType clickedWord in _clickedSingleWords) {
        clickedWord.setIsClick(false);
      }
    }

    // -------------
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
    notifyListeners();
  }

  void nextLevel() {
    _clickedSingleWords = [];

    _correctCnt = 0;
    isWordCorrect = false;
    isAllCorrect = false;
    notifyListeners();
  }

  void initScore() async {
    correctScore = await util.getSharedData<int>('score') ?? 0;
    notifyListeners();
  }

  void initStage(
    List<dynamic> wordObjList,
    List<CreatedSingleWordType> singleWordObjList,
  ) {
    _correctWordList = wordObjList;
    _singleWordObjInstanceList = singleWordObjList;

    gameStatus = GAME_STATUS.START;
    retry();
    notifyListeners();
  }

  void stopStage() {
    print('stop');
    gameStatus = GAME_STATUS.STOP;

    notifyListeners();
  }
}
