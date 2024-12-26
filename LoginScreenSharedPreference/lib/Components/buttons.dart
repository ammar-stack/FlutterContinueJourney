import 'package:flutter/material.dart';

class buttoncontainer extends StatelessWidget {
  String buttonText;
  buttoncontainer({required this.buttonText,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: Text(buttonText,style:const TextStyle(color: Colors.white,fontSize: 24),),
        ),
      ),
    );
  }
}