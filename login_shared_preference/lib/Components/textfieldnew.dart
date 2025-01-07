import 'package:flutter/material.dart';

class TextFieldNew extends StatelessWidget {
  TextEditingController controllerr;
  String hintText;
   TextFieldNew({required this.hintText,required this.controllerr,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controllerr,
        decoration: InputDecoration(
          border:const OutlineInputBorder(),
          hintText: hintText
        ),
      ),
    );
  }
}