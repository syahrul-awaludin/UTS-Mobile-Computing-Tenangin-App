import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TenanginLogo extends StatelessWidget {
  final double fontSize;
  final Color color;

  const TenanginLogo({
    super.key,
    this.fontSize = 24,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: -0.5,
        ),
        children: [
          const TextSpan(text: 't'),
          TextSpan(
            text: 'e',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const TextSpan(text: 'nangin'),
        ],
      ),
    );
  }
}
