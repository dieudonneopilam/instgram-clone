import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content)));
}
