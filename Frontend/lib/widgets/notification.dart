import 'package:flutter/material.dart';

import '../services/methods.dart';

///Display a notification at the bottom of the screen
///
///Uses [textSize] to determine the size of the notification text
SnackBar notification(String message, BuildContext context) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    width: textSize(message, Theme.of(context).textTheme.bodyText1!).width,
    content: Text(message, textAlign: TextAlign.center,),
    duration: const Duration(milliseconds: 1500),
  );
}
   
