import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/page/MyHomePage.dart';
import 'package:real_word/provider/WordProvider.dart';
import 'package:real_word/widget/WrapScaffold.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<int> wordKeyList = [3, 4, 5];
  late int wordKeyValue;

  @override
  void initState() {
    wordKeyValue = wordKeyList.first;
  }

  @override
  Widget build(BuildContext context) {
    WordProvider wordProvider =
        Provider.of<WordProvider>(context, listen: false);
    return WrapScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: wordKeyValue,
              items: wordKeyList.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('${value.toString()}단어'),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  wordKeyValue = value!;
                });
              },
            ),
            ElevatedButton(
              child: Text('시작'),
              onPressed: () {
                print(wordKeyValue);
                wordProvider.setSingleWordCnt(wordKeyValue);
                Navigator.pushNamed(
                  context,
                  MyHomePage.routeName,
                  arguments: {'wordKey': wordKeyValue},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
