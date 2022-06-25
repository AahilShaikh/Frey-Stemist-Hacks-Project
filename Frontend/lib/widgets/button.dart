import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  SizedButton({required this.onPressed, required this.text, required this.width, required this.height, required this.fontSize});

  final GestureTapCallback onPressed;
  final String text;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 20,
          primary: Colors.blue,
          onPrimary: Colors.white,
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ExpandedButton extends StatelessWidget {
  ExpandedButton({required this.onPressed, required this.text, required this.flex, required this.fontSize});

  final GestureTapCallback onPressed;
  final String text;
  final int flex;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 20,
          primary: Colors.white,
          onPrimary: Colors.black,
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
