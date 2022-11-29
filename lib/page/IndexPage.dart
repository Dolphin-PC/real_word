import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/page/MyHomePage.dart';
import 'package:real_word/provider/WordProvider.dart';
import 'package:real_word/util/util.dart';
import 'package:real_word/widget/WrapScaffold.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Util util = Util();
  List<String> wordKeyList = ['0'];
  String wordKeyValue = '0';
  int? score;

  late WordProvider wordProvider;

  @override
  void initState() {
    super.initState();
    util.getWordKeyFromJson().then((value) {
      setState(() {
        wordKeyList = value;
        wordKeyValue = wordKeyList.first;
      });
    });

    util.execAfterOnlyBinding(() {
      wordProvider.initScore();

      double screenWidth = MediaQuery.of(context).size.width;
      wordProvider.setScreenWidth(screenWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: true);

    return WrapScaffold(
      // isBottom: true,
      isFloating: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('내가 맞힌 단어 수 : ${wordProvider.correctScore}'),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  value: wordKeyValue,
                  items:
                      wordKeyList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('${value.toString()}단어'),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      wordKeyValue = value!;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('시작'),
                  onPressed: () {
                    wordProvider.setSingleWordCnt(int.parse(wordKeyValue));
                    Navigator.pushNamed(
                      context,
                      MyHomePage.routeName,
                      arguments: {'wordKey': wordKeyValue},
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
