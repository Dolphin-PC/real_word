import 'package:flutter/material.dart';
import 'package:real_word/page/MyHomePage.dart';
import 'package:real_word/widget/WrapScaffold.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<String> wordKeyList = ['key_3', 'key_4', 'key_5'];
  late String wordKeyValue;

  @override
  void initState() {
    wordKeyValue = wordKeyList.first;
  }

  @override
  Widget build(BuildContext context) {
    return WrapScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: wordKeyValue,
              items: wordKeyList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
