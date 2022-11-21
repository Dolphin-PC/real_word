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
  List<CreatedWordType> wordObjList = [];
  Util util = Util();

  @override
  initState() {
    setState(() {
      wordObjList = util.createWord(); // 단어 생성
    });
  }

  void shuffelWord() {
    setState(() {
      util.shuffle(wordObjList); // 단어 위치 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    int cnt = Provider.of<WordProvider>(context).getWordCnt();
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
              children: util.renderText(wordObjList, cnt),
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
                    onPressed: util.createWord,
                    tooltip: 'create word',
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: shuffelWord,
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
