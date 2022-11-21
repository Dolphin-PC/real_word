import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/WordProvider.dart';
import 'package:real_word/util/util.dart';

import '../util/structure.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> orgWordObjList = [];
  List<CreatedSingleWordType> wordObjList = [];
  Util util = Util();
  late WordProvider wordProvider;

  void initState() {
    super.initState();
    setState(() {
      orgWordObjList = util.getWordFromJson(); // 원본 데이터 get
      wordObjList = util.createSingleWord(orgWordObjList); // 단어 쪼개서 생성하기
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      util.shuffle(wordObjList); // 단어 위치 변경
      wordProvider.setCorrectWordList(orgWordObjList);
    });
  }
  // @override
  // initState() {
  //   setState(() {
  //     orgWordObjList = util.getWordFromJson(); // 원본 데이터 get
  //     wordObjList = util.createSingleWord(orgWordObjList); // 단어 쪼개서 생성하기
  //   });
  // }

  void shuffleWord() {
    setState(() {
      util.shuffle(wordObjList); // 단어 위치 변경
      wordProvider.setCorrectWordList(orgWordObjList);
    });
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<WordProvider>(
                builder: (context, countProvider, child) => Text(
                  Provider.of<WordProvider>(context)
                      .getClickedWordsString()
                      .toString(),
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  util.renderText(wordObjList, wordProvider.getSingleWordCnt()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: shuffleWord,
                    tooltip: 'shuffle word',
                    child: const Icon(Icons.shuffle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
