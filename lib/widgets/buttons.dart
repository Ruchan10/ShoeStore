import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Color textColor;
  final bool fill;
  final double width;
  const Button({
    super.key,
    required this.label,
    required this.textColor,
    this.fill = false,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: ShapeDecoration(
            color: fill ? const Color(0xFF0F0F0F) : Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE7E7E7)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: 0.14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
