import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String title,
    [bool error = false,var seconds]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds),
      content: Text(title),
      backgroundColor: error ? Colors.red : null,
    ),
  );
}
