import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_word/util/util.dart';

Util util = Util();
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('랜덤 idx 가져오기', () async {
    final String jsonString = await rootBundle.loadString('data/tdata.json');
    Map<String, dynamic> orgJson = jsonDecode(jsonString);
    print(orgJson);
    // print(util.getRandomIdx(orgJson, 4));
  });
}
