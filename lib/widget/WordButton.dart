import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/provider/WordProvider.dart';

import '../enum.dart';
import '../util/structure.dart';

class WordButton extends StatefulWidget {
  const WordButton({Key? key, required this.createdWordType}) : super(key: key);

  final CreatedSingleWordType createdWordType;

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
    wordProvider = Provider.of<WordProvider>(context, listen: true);

    return Container(
      margin: const EdgeInsets.all(10),
      width: 50,
      height: 50,
      color: Colors.lightGreen[50],
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ElevatedButton(
          onPressed: widget.createdWordType.isCorrect() ||
                  wordProvider.gameStatus == GAME_STATUS.STOP
              ? null
              : onClick,
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
                fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
