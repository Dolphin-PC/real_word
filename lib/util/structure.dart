class CreatedWordType {
  late String _word;
  late EqaulType _equal;
  late bool _isClick;
  late bool _isCorrect;

  CreatedWordType add(String word, int id, int sq) {
    _word = word;
    _equal = EqaulType(id, sq);
    _isClick = false;
    _isCorrect = false;

    return this;
  }

  String getWord() => _word;
  EqaulType getEqualObj() => _equal;
  bool isClick() => _isClick;
  bool isCorrect() => _isCorrect;

  void onClick() => _isClick = !_isClick;
  void setIsClick(bool enable) => _isClick = enable;
  void setIsCorrect(bool enable) => _isCorrect = enable;
}

class EqaulType {
  late int _id; // 동일한 단어인지 판단
  late int _sq; // 단어의 순서

  EqaulType(int id, int sq) {
    _id = id;
    _sq = sq;
  }

  int getId() => _id;
  int getSq() => _sq;
}
