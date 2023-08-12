import 'package:flutter/material.dart';

class ButtomFollow extends StatelessWidget {
  const ButtomFollow({super.key, required this.function, required this.label});
  final VoidCallback function;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: function,
          child: Container(
            width: 250,
            height: 27,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
