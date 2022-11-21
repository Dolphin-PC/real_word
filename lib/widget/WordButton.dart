import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/WordProvider.dart';

import '../util/structure.dart';

class WordButton extends StatefulWidget {
  WordButton({Key? key, required this.createdWordType}) : super(key: key);

  final CreatedWordType createdWordType;

  @override
  State<WordButton> createState() => _WordButtonState();
}

class _WordButtonState extends State<WordButton> {
  late WordProvider wordProvider;

  void onClick() {
    setState(() {
      widget.createdWordType.onClick();
    });
    wordProvider.wordClick(widget.createdWordType);
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        onPressed: widget.createdWordType.isCorrect() ? null : onClick,
        style: ElevatedButton.styleFrom(
          primary: widget.createdWordType.isClick()
              ? Colors.blueAccent
              : Colors.grey,
        ),
        child: Text(widget.createdWordType.getWord()),
      ),
    );
  }
}
