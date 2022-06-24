import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class clearAppBar extends StatelessWidget {
  const clearAppBar({super.key, required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        color: Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
