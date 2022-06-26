import 'package:flutter/material.dart';

class TextQuestion extends StatefulWidget {
  final String question;
  final TextEditingController controller;
  TextQuestion({Key? key, required this.question, required this.controller}) : super(key: key);

  @override
  State<TextQuestion> createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Text(widget.question)),
          Expanded(child: TextField(controller: widget.controller,))
          ],

      ),
    );
  }
}
