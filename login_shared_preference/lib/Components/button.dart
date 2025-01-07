import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonNew extends StatelessWidget {
  String buttonText;
  ButtonNew({required this.buttonText,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration:const BoxDecoration(
        color: Colors.brown,
        
      ),
      child: Center(child: Text(buttonText,style: GoogleFonts.abel(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.yellowAccent),)),
    );
  }
}