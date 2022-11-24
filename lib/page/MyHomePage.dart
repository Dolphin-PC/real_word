import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/WordProvider.dart';
import 'package:real_word/util/util.dart';
import 'package:real_word/widget/CustomDialog.dart';
import 'package:real_word/widget/WrapScaffold.dart';

import '../util/structure.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> wordObjList = [];
  List<CreatedSingleWordType> org_singleWordObjList = [];
  List<CreatedSingleWordType> singleWordObjList = [];
  Util util = Util();
  late WordProvider wordProvider;
  late var args;

  @override
  void initState() {
    super.initState();

    // build 때 까지 기다렸다가 1번만 실행
    util.execAfterOnlyBinding(() {
      wordInit();
    });
  }

  void wordInit() {
    String wordKeyName = 'key_${wordProvider.getSingleWordCnt()}';
    util.getWordFromJson(wordKeyName).then((dataList) {
      setState(() {
        wordObjList = dataList;
        singleWordObjList = util.createSingleWord(wordObjList); // 단어 쪼개서 생성하기
        org_singleWordObjList =
            util.createSingleWord(wordObjList); // 단어 쪼개서 생성하기
      });
    });
    before_shuffle();
  }

  void before_shuffle() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          context: context,
          title: '',
          msg: '3초 뒤에 단어가 섞입니다.',
          fn: shuffle,
          btnList: {},
        );
      },
    );
  }

  void shuffle() {
    wordProvider.stopStage();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        util.shuffle(singleWordObjList); // 단어 위치 변경
        wordProvider.initStage(wordObjList, singleWordObjList);
      });
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
                  retry();
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

  void retry() {
    setState(() {
      singleWordObjList = [...org_singleWordObjList];
      wordProvider.retry();
      before_shuffle();
    });
  }

  void nextLevel() {
    wordProvider.nextLevel();
    wordInit();
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: true);
    args = ModalRoute.of(context)!.settings.arguments;

    wordProvider.isAllCorrect ? isAllCorrect() : null;
    return WrapScaffold(
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
              child: util.renderWord(singleWordObjList,
                  wordProvider.getSingleWordCnt(), wordProvider.screenWidth)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: retry,
                    tooltip: '재시도',
                    child: const Icon(Icons.rotate_right),
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
