import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/WordProvider.dart';
import 'package:real_word/util/util.dart';
import 'package:real_word/widget/CustomDialog.dart';

import '../util/structure.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> wordObjList = [];
  List<CreatedSingleWordType> singleWordObjList = [];
  Util util = Util();
  late WordProvider wordProvider;

  void initState() {
    super.initState();
    wordInit();
  }

  void wordInit([wordKeyName = 'key_4']) {
    void shuffle() {
      Timer(Duration(seconds: 1), () {
        setState(() {
          // util.shuffle(singleWordObjList); // 단어 위치 변경
          wordProvider.setCorrectWordList(wordObjList);
          wordProvider.setSingleWordObjList(singleWordObjList);
        });
      });
    }

    util.getWordFromJson(wordKeyName).then((dataList) {
      setState(() {
        wordObjList = dataList;
        singleWordObjList = util.createSingleWord(wordObjList); // 단어 쪼개서 생성하기
      });

      shuffle();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return CustomDialog(
      //       context: context,
      //       title: '',
      //       msg: '3초 뒤에 단어가 섞입니다.',
      //       fn: shuffle,
      //     );
      //   },
      // );
    });
  }

  void isAllCorrect() {
    if (wordProvider.isAllCorrect) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            // return CustomDialog(context: context, title: 'dasd', msg: 'fdsf');
            return CustomDialog(
              context: context,
              title: 'Stage Clear',
              msg: '정답입니다!',
              fn: () {},
              btnList: {
                '재시도': () {
                  Navigator.of(context).pop();
                  setState(() => wordProvider.retry());
                },
                '다음': () {
                  Navigator.of(context).pop();
                  nextLevel();
                },
              },
            );
          },
        );
      });
    }
  }

  void nextLevel() {
    wordProvider.nextLevel();
    wordInit();
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: true);
    isAllCorrect();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
          color: Colors.white,
        ),
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
                  style: const TextStyle(
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.w900,
                    fontSize: 60,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: util.renderText(
                  singleWordObjList, wordProvider.getSingleWordCnt()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
