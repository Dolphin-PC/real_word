import 'package:flutter/material.dart';
import 'package:real_word/widget/WrapScaffold.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return WrapScaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('다음 이동'),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}
