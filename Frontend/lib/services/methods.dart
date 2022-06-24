import 'dart:math';

import 'package:flutter/material.dart';

///The characters allowed in game room code.
///
///Used with [getRandomString] to generate a random code.
const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
Random _rnd = Random();

///Method to generate random game room codes for multiplayer events
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

///Change the size of a text to fit the available space
Size textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
