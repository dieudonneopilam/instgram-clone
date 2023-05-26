import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPass;
  final TextInputType type;

  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.hint,
      this.isPass = false,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        border: inputBorder,
        hintText: hint,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
      ),
      keyboardType: type,
      obscureText: isPass,
    );
  }
}
