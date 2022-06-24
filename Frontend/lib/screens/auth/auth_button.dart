import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const AuthButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(300, 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: const BorderSide(color: Colors.white)))),
      child: AutoSizeText(widget.text, style: const TextStyle(color: Colors.white),),
    );
  }
}