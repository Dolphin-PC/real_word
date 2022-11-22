import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String msg;
  final Function fn;
  final Map<String, Function> btnList;

  // List<Function> btnList;

  const CustomDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.msg,
    required this.fn,
    required this.btnList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(title),
      content: Text(msg),
      actions: btnList.isEmpty
          ? <Widget>[
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                  fn();
                },
              )
            ]
          : btnList.entries.map((e) {
              return ElevatedButton(
                child: Text(e.key),
                onPressed: () {
                  e.value();
                },
              );
            }).toList(),
    );
  }
}
