import 'package:flutter/material.dart';

void showSnackBarGlobal(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    textScaleFactor: 2,
  )));
}
