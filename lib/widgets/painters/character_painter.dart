import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Paints the pink flower character from the onboarding screen
class FlowerCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width * 0.45;
    final centerY = size.height * 0.45;
    final radius = size.width * 0.35;
    _drawStarBody(canvas, centerX, centerY, radius);
    _drawFace(canvas, centerX, centerY, radius * 0.5);
    _drawArms(canvas, centerX, centerY, radius);
    _drawLegs(canvas, centerX, centerY, radius);
  }

  void _drawStarBody(Canvas canvas, double cx, double cy, double radius) {
    final paint = Paint()
      ..color = const Color(0xFFFF8FAD)
      ..style = PaintingStyle.fill;
    final path = Path();
    const points = 10;
    final outerR = radius * 1.1;
    final innerR = radius * 0.85;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? outerR : innerR;
      final angle = (i * math.pi / points) - (math.pi / 2);
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      if (i == 0) { path.moveTo(x, y); } else { path.lineTo(x, y); }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawFace(Canvas canvas, double cx, double cy, double faceRadius) {
    final eyePaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final pupilPaint = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.fill;
    final eyeY = cy - faceRadius * 0.15;
    final eyeSpacing = faceRadius * 0.45;
    final eyeR = faceRadius * 0.28;
    canvas.drawCircle(Offset(cx - eyeSpacing, eyeY), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx - eyeSpacing, eyeY), eyeR * 0.5, pupilPaint);
    canvas.drawCircle(Offset(cx + eyeSpacing, eyeY), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx + eyeSpacing, eyeY), eyeR * 0.5, pupilPaint);
    final smilePaint = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    final smilePath = Path();
    final smileY = cy + faceRadius * 0.2;
    smilePath.moveTo(cx - faceRadius * 0.3, smileY);
    smilePath.quadraticBezierTo(cx, smileY + faceRadius * 0.35, cx + faceRadius * 0.3, smileY);
    canvas.drawPath(smilePath, smilePaint);
  }

  void _drawArms(Canvas canvas, double cx, double cy, double radius) {
    final paint = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.stroke..strokeWidth = 3..strokeCap = StrokeCap.round;
    final leftArmPath = Path()
      ..moveTo(cx - radius * 0.8, cy - radius * 0.2)
      ..quadraticBezierTo(cx - radius * 1.2, cy - radius * 0.8, cx - radius * 1.0, cy - radius * 1.2);
    canvas.drawPath(leftArmPath, paint);
    final rightArmPath = Path()
      ..moveTo(cx + radius * 0.8, cy - radius * 0.3)
      ..quadraticBezierTo(cx + radius * 1.3, cy - radius * 0.9, cx + radius * 1.1, cy - radius * 1.3);
    canvas.drawPath(rightArmPath, paint);
  }

  void _drawLegs(Canvas canvas, double cx, double cy, double radius) {
    final paint = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.stroke..strokeWidth = 3..strokeCap = StrokeCap.round;
    final leftLegPath = Path()
      ..moveTo(cx - radius * 0.3, cy + radius * 0.8)
      ..lineTo(cx - radius * 0.5, cy + radius * 1.4)
      ..lineTo(cx - radius * 0.7, cy + radius * 1.35);
    canvas.drawPath(leftLegPath, paint);
    final rightLegPath = Path()
      ..moveTo(cx + radius * 0.3, cy + radius * 0.8)
      ..lineTo(cx + radius * 0.5, cy + radius * 1.4)
      ..lineTo(cx + radius * 0.7, cy + radius * 1.35);
    canvas.drawPath(rightLegPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Decorative squiggle painter
class SquigglePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  SquigglePainter({required this.color, this.strokeWidth = 2.5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.75, size.height, size.width, size.height * 0.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Sad blue character for the Learn Detail header
class SadBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.55;
    final r = size.width * 0.4;
    final bodyPaint = Paint()..color = const Color(0xFF48BFE3)..style = PaintingStyle.fill;
    final path = Path();
    const bumps = 7;
    for (int i = 0; i <= bumps * 2; i++) {
      final radius = i.isEven ? r : r * 0.8;
      final angle = (i * math.pi / bumps) - (math.pi / 2);
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevAngle = ((i - 1) * math.pi / bumps) - (math.pi / 2);
        final ctrlX = cx + (r * 1.1) * math.cos((angle + prevAngle) / 2);
        final ctrlY = cy + (r * 1.1) * math.sin((angle + prevAngle) / 2);
        path.quadraticBezierTo(ctrlX, ctrlY, x, y);
      }
    }
    path.close();
    canvas.drawPath(path, bodyPaint);
    final eyeWhite = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final pupil = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx - r * 0.3, cy - r * 0.2), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx - r * 0.25, cy - r * 0.3), r * 0.12, pupil);
    canvas.drawCircle(Offset(cx + r * 0.3, cy - r * 0.2), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx + r * 0.25, cy - r * 0.3), r * 0.12, pupil);
    final mouthPaint = Paint()..color = const Color(0xFF242528)..style = PaintingStyle.stroke..strokeWidth = 3.5..strokeCap = StrokeCap.round;
    final mouth = Path()
      ..moveTo(cx - r * 0.3, cy + r * 0.25)
      ..quadraticBezierTo(cx, cy - r * 0.05, cx + r * 0.3, cy + r * 0.25);
    canvas.drawPath(mouth, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

