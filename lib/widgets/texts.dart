import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String label;
  final Color textColor;
  final FontWeight weight;
  final double height;
  final double size;
  final double letterSpacing;
  const MyText({
    super.key,
    required this.label,
    required this.textColor,
    this.weight = FontWeight.w400,
    this.size = 12,
    this.height = 0.15,
    this.letterSpacing = 0.12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // width: 94,
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: size,
              fontFamily: 'Urbanist',
              fontWeight: weight,
              height: height,
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ],
    );
  }
}
