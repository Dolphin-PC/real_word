import 'package:flutter/material.dart';
import 'package:real_word/util/structure.dart';
import 'package:real_word/widget/WordButton.dart';

class CustomColumn extends StatelessWidget {
  const CustomColumn({Key? key, required this.word}) : super(key: key);

  final CreatedWordType word;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 50,
          height: 50,
          color: Colors.lightGreen[50],
          child: WordButton(createdWordType: word),
        ),
      ],
    );
  }
}
