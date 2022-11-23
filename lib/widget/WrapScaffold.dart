import 'package:flutter/material.dart';

class WrapScaffold extends StatelessWidget {
  late final Widget? _title;
  late final Widget _body;

  WrapScaffold({Key? key, Widget? title, required Widget body})
      : super(key: key) {
    title == null ? _title = const Text('Real Word') : _title = title;
    _body = body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title,
      ),
      body: _body,
    );
  }
}
