import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A35B0).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.8,
        size.width,
        size.height * 0.4,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RainbowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFFFF6B6B),
      const Color(0xFFFF9F43),
      const Color(0xFFFFD166),
      const Color(0xFF7BCC70),
      const Color(0xFF48BFE3),
      const Color(0xFFAEC6F3),
      const Color(0xFFF2B5D4),
    ];
    final center = Offset(size.width / 2, size.height);
    for (int i = 0; i < colors.length; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: 90.0 - (i * 10)),
        3.14159,
        3.14159,
        false,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
