import 'package:flutter/material.dart';
import 'package:real_word/util/structure.dart';
import 'package:real_word/widget/WordButton.dart';

class CustomColumn extends StatelessWidget {
  const CustomColumn({Key? key, required this.word}) : super(key: key);

  final CreatedSingleWordType word;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [WordButton(createdWordType: word)],
    );
  }
}
