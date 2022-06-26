import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  const RowText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.text2});

  final String text;
  final String text2;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
         Spacer(),
          Text(
            text2,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ]);
  }
}
