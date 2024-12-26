import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  double size;
  VerticalSpacing({required this.size,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}

class HorizontalSpacing extends StatelessWidget {
  double size;
  HorizontalSpacing({required this.size,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}