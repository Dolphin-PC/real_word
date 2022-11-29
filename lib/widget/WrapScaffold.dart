import 'package:flutter/material.dart';
import 'package:real_word/widget/CustomDialog.dart';

import 'PrivacyLink.dart';

class WrapScaffold extends StatefulWidget {
  late final Widget? _title;
  late final Widget body;
  late final bool isBottom;
  late final bool isFloating;

  WrapScaffold(
      {Key? key,
      Widget? title,
      required this.body,
      this.isBottom = false,
      this.isFloating = false})
      : super(key: key) {
    title == null ? _title = const Text('Real Word') : _title = title;
  }

  @override
  State<WrapScaffold> createState() => _WrapScaffoldState();
}

class _WrapScaffoldState extends State<WrapScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget._title,
      ),
      body: widget.body,
      floatingActionButton: widget.isFloating
          ? FloatingActionButton(
              child: const Icon(Icons.question_mark),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      context: context,
                      title: '개인정보처리방침',
                      msg: '',
                      msgWidget: const PrivacyLink(),
                      fn: () {},
                      btnList: {'닫기': () => Navigator.pop(context)},
                    );
                  },
                );
              },
            )
          : null,
      bottomNavigationBar: widget.isBottom
          ? BottomNavigationBar(
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'HOME'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'SETTING'),
                ],
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() => _selectedIndex = index);
              })
          : null,
    );
  }
}
