import 'package:flutter/material.dart';
import 'package:real_word/widget/CustomColumn.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({Key? key, required this.column}) : super(key: key);

  final List<CustomColumn> column;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: column,
    );
  }
}
