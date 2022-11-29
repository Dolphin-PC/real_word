import 'package:flutter/material.dart';

class WrapScaffold extends StatefulWidget {
  late final Widget? _title;
  late final Widget body;
  late final bool isBottom;

  WrapScaffold(
      {Key? key, Widget? title, required this.body, this.isBottom = false})
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
