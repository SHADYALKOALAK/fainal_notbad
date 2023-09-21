import 'package:flutter/material.dart';

mixin ChickData {
  void showSnackBar(BuildContext context, String massage, bool error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error ? Colors.red : Theme.of(context).primaryColor,
        content: Text(massage),
      ),
    );
  }
}
