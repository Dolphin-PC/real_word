import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/CommProvider.dart';
import 'package:real_word/provider/WordProvider.dart';

import '../util/structure.dart';

class WordButton extends StatefulWidget {
  WordButton({Key? key, required this.createdWordType}) : super(key: key);

  final CreatedSingleWordType createdWordType;

  @override
  State<WordButton> createState() => _WordButtonState();
}

class _WordButtonState extends State<WordButton> {
  late WordProvider wordProvider;
  late CommProvider commProvider;

  void onClick() {
    setState(() {
      widget.createdWordType.onClick();
    });
    wordProvider.wordClick(widget.createdWordType);
  }

  @override
  Widget build(BuildContext context) {
    wordProvider = Provider.of<WordProvider>(context, listen: false);
    commProvider = Provider.of<CommProvider>(context, listen: false);
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
        child: Text(
          widget.createdWordType.getWord(),
          style: const TextStyle(
              fontFamily: 'ComicNeue',
              fontWeight: FontWeight.w700,
              fontSize: 24.0),
        ),
      ),
    );
  }
}
