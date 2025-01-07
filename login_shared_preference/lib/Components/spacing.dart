import 'package:flutter/material.dart';

class VerticalS extends StatelessWidget {
  double value;
   VerticalS({required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value,);
  }
}

class HorizontalS extends StatelessWidget {
  double value;
   HorizontalS({required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value,);
  }
}