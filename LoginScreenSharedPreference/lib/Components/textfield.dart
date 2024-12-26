import 'package:flutter/material.dart';

class TextFieldd extends StatelessWidget {
  String hint;
  TextEditingController co;
  TextFieldd({required this.co,required this.hint,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: co,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          )
        ),
      ),
    );
  }
}