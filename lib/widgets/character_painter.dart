import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Paints the pink flower character from the onboarding screen
class FlowerCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width * 0.45;
    final centerY = size.height * 0.45;
    final radius = size.width * 0.35;

    // Draw petals (star shape body)
    _drawStarBody(canvas, centerX, centerY, radius);

    // Draw face
    _drawFace(canvas, centerX, centerY, radius * 0.5);

    // Draw arms
    _drawArms(canvas, centerX, centerY, radius);

    // Draw legs
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
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawFace(Canvas canvas, double cx, double cy, double faceRadius) {
    // Eyes - white circles with black pupils
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupilPaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;

    final eyeY = cy - faceRadius * 0.15;
    final eyeSpacing = faceRadius * 0.45;
    final eyeR = faceRadius * 0.28;
    final pupilR = eyeR * 0.5;

    // Left eye
    canvas.drawCircle(Offset(cx - eyeSpacing, eyeY), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx - eyeSpacing, eyeY), pupilR, pupilPaint);

    // Right eye
    canvas.drawCircle(Offset(cx + eyeSpacing, eyeY), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx + eyeSpacing, eyeY), pupilR, pupilPaint);

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final smilePath = Path();
    final smileY = cy + faceRadius * 0.2;
    smilePath.moveTo(cx - faceRadius * 0.3, smileY);
    smilePath.quadraticBezierTo(
      cx, smileY + faceRadius * 0.35,
      cx + faceRadius * 0.3, smileY,
    );
    canvas.drawPath(smilePath, smilePaint);
  }

  void _drawArms(Canvas canvas, double cx, double cy, double radius) {
    final paint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Left arm (waving up)
    final leftArmPath = Path();
    leftArmPath.moveTo(cx - radius * 0.8, cy - radius * 0.2);
    leftArmPath.quadraticBezierTo(
      cx - radius * 1.2, cy - radius * 0.8,
      cx - radius * 1.0, cy - radius * 1.2,
    );
    canvas.drawPath(leftArmPath, paint);

    // Right arm (up)
    final rightArmPath = Path();
    rightArmPath.moveTo(cx + radius * 0.8, cy - radius * 0.3);
    rightArmPath.quadraticBezierTo(
      cx + radius * 1.3, cy - radius * 0.9,
      cx + radius * 1.1, cy - radius * 1.3,
    );
    canvas.drawPath(rightArmPath, paint);
  }

  void _drawLegs(Canvas canvas, double cx, double cy, double radius) {
    final paint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Left leg
    final leftLegPath = Path();
    leftLegPath.moveTo(cx - radius * 0.3, cy + radius * 0.8);
    leftLegPath.lineTo(cx - radius * 0.5, cy + radius * 1.4);
    leftLegPath.lineTo(cx - radius * 0.7, cy + radius * 1.35);
    canvas.drawPath(leftLegPath, paint);

    // Right leg
    final rightLegPath = Path();
    rightLegPath.moveTo(cx + radius * 0.3, cy + radius * 0.8);
    rightLegPath.lineTo(cx + radius * 0.5, cy + radius * 1.4);
    rightLegPath.lineTo(cx + radius * 0.7, cy + radius * 1.35);
    canvas.drawPath(rightLegPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Paints the orange triangle character from the onboarding screen
class TriangleCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.4;
    final triSize = size.width * 0.7;

    // Triangle body
    _drawTriangleBody(canvas, cx, cy, triSize);

    // Face
    _drawFace(canvas, cx, cy + triSize * 0.1);

    // Arms
    _drawArms(canvas, cx, cy, triSize);

    // Legs
    _drawLegs(canvas, cx, cy, triSize);
  }

  void _drawTriangleBody(Canvas canvas, double cx, double cy, double size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9F43)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(cx, cy - size * 0.45);
    path.lineTo(cx + size * 0.45, cy + size * 0.35);
    path.lineTo(cx - size * 0.45, cy + size * 0.35);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawFace(Canvas canvas, double cx, double cy) {
    // Sleepy/calm eyes (half closed)
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupilPaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;
    final lidPaint = Paint()
      ..color = const Color(0xFFE88B30)
      ..style = PaintingStyle.fill;

    const eyeSpacing = 12.0;
    const eyeR = 6.0;

    // Left eye
    canvas.drawCircle(Offset(cx - eyeSpacing, cy), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx - eyeSpacing, cy), eyeR * 0.5, pupilPaint);
    // Eyelid (half closed)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx - eyeSpacing, cy), radius: eyeR),
      -math.pi, math.pi * 0.6, true, lidPaint,
    );

    // Right eye
    canvas.drawCircle(Offset(cx + eyeSpacing, cy), eyeR, eyePaint);
    canvas.drawCircle(Offset(cx + eyeSpacing, cy), eyeR * 0.5, pupilPaint);
    // Eyelid
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx + eyeSpacing, cy), radius: eyeR),
      -math.pi, math.pi * 0.6, true, lidPaint,
    );

    // Small smile
    final smilePaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(cx - 6, cy + 10);
    path.quadraticBezierTo(cx, cy + 15, cx + 6, cy + 10);
    canvas.drawPath(path, smilePaint);
  }

  void _drawArms(Canvas canvas, double cx, double cy, double size) {
    final paint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Left arm
    final leftArm = Path();
    leftArm.moveTo(cx - size * 0.3, cy + size * 0.15);
    leftArm.quadraticBezierTo(
      cx - size * 0.55, cy + size * 0.05,
      cx - size * 0.5, cy + size * 0.25,
    );
    canvas.drawPath(leftArm, paint);

    // Right arm (waving)
    final rightArm = Path();
    rightArm.moveTo(cx + size * 0.3, cy + size * 0.15);
    rightArm.quadraticBezierTo(
      cx + size * 0.55, cy - size * 0.05,
      cx + size * 0.6, cy + size * 0.15,
    );
    canvas.drawPath(rightArm, paint);
  }

  void _drawLegs(Canvas canvas, double cx, double cy, double size) {
    final paint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final legY = cy + size * 0.35;

    // Left leg
    canvas.drawLine(
      Offset(cx - size * 0.15, legY),
      Offset(cx - size * 0.2, legY + size * 0.25),
      paint,
    );

    // Right leg
    canvas.drawLine(
      Offset(cx + size * 0.15, legY),
      Offset(cx + size * 0.2, legY + size * 0.25),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Green blob character for home banner
class GreenBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.45;
    final r = size.width * 0.38;

    // Blob body
    final bodyPaint = Paint()
      ..color = const Color(0xFF7BCC70)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    canvas.drawPath(path, bodyPaint);

    // Decorative bumps on top
    canvas.drawCircle(Offset(cx - r * 0.3, cy - r * 0.85), r * 0.2, bodyPaint);
    canvas.drawCircle(Offset(cx + r * 0.3, cy - r * 0.85), r * 0.2, bodyPaint);

    // Eyes
    final eyeWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupil = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx - r * 0.35, cy - r * 0.1), r * 0.22, eyeWhite);
    canvas.drawCircle(Offset(cx + r * 0.35, cy - r * 0.1), r * 0.22, eyeWhite);
    canvas.drawCircle(Offset(cx - r * 0.35, cy - r * 0.1), r * 0.1, pupil);
    canvas.drawCircle(Offset(cx + r * 0.35, cy - r * 0.1), r * 0.1, pupil);

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final smile = Path();
    smile.moveTo(cx - r * 0.25, cy + r * 0.2);
    smile.quadraticBezierTo(cx, cy + r * 0.5, cx + r * 0.25, cy + r * 0.2);
    canvas.drawPath(smile, smilePaint);
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

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25, 0,
      size.width * 0.5, size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height,
      size.width, size.height * 0.5,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Orange/pink character for meditation cards
class MeditationCharacterPainter extends CustomPainter {
  final Color bodyColor;
  final Color accentColor;
  final bool isHappy;

  MeditationCharacterPainter({
    required this.bodyColor,
    required this.accentColor,
    this.isHappy = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.32;

    // Star body
    final paint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill;

    final path = Path();
    const points = 8;
    final outerR = r;
    final innerR = r * 0.78;

    for (int i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerR : innerR;
      final angle = (i * math.pi / points) - (math.pi / 2);
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);

    // Eyes
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupilPaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;

    final eyeY = cy - r * 0.1;
    canvas.drawCircle(Offset(cx - r * 0.3, eyeY), r * 0.18, eyePaint);
    canvas.drawCircle(Offset(cx + r * 0.3, eyeY), r * 0.18, eyePaint);
    canvas.drawCircle(Offset(cx - r * 0.3, eyeY), r * 0.08, pupilPaint);
    canvas.drawCircle(Offset(cx + r * 0.3, eyeY), r * 0.08, pupilPaint);

    // Mouth
    final mouthPaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    if (isHappy) {
      final smile = Path();
      smile.moveTo(cx - r * 0.2, cy + r * 0.15);
      smile.quadraticBezierTo(cx, cy + r * 0.35, cx + r * 0.2, cy + r * 0.15);
      canvas.drawPath(smile, mouthPaint);
    } else {
      final frown = Path();
      frown.moveTo(cx - r * 0.15, cy + r * 0.25);
      frown.quadraticBezierTo(cx, cy + r * 0.1, cx + r * 0.15, cy + r * 0.25);
      canvas.drawPath(frown, mouthPaint);
    }

    // Chat bubble accent
    final bubblePaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final bubbleCx = cx + r * 0.6;
    final bubbleCy = cy - r * 0.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(bubbleCx, bubbleCy), width: r * 0.6, height: r * 0.45),
        Radius.circular(r * 0.15),
      ),
      bubblePaint,
    );
    // Bubble tail
    final tailPath = Path();
    tailPath.moveTo(bubbleCx - r * 0.1, bubbleCy + r * 0.2);
    tailPath.lineTo(bubbleCx - r * 0.2, bubbleCy + r * 0.35);
    tailPath.lineTo(bubbleCx + r * 0.05, bubbleCy + r * 0.2);
    tailPath.close();
    canvas.drawPath(tailPath, bubblePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Orange cloud character for the Login screen header
class CloudCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.45;
    final r = size.width * 0.35;

    // Cloud Body (Wavy shape)
    final bodyPaint = Paint()
      ..color = const Color(0xFFFF9F43) // Orange color from design
      ..style = PaintingStyle.fill;

    final path = Path();
    const bumps = 8;
    for (int i = 0; i <= bumps * 2; i++) {
      final radius = i.isEven ? r : r * 0.75;
      final angle = (i * math.pi / bumps) - (math.pi / 2);
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevRadius = (i - 1).isEven ? r : r * 0.75;
        final prevAngle = ((i - 1) * math.pi / bumps) - (math.pi / 2);
        
        final ctrlX = cx + (r * 1.1) * math.cos((angle + prevAngle) / 2);
        final ctrlY = cy + (r * 1.1) * math.sin((angle + prevAngle) / 2);
        
        path.quadraticBezierTo(ctrlX, ctrlY, x, y);
      }
    }
    path.close();
    canvas.drawPath(path, bodyPaint);

    // Eyes
    final eyeWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupil = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx - r * 0.25, cy - r * 0.1), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx - r * 0.2, cy - r * 0.15), r * 0.12, pupil);
    
    canvas.drawCircle(Offset(cx + r * 0.25, cy - r * 0.1), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx + r * 0.2, cy - r * 0.15), r * 0.12, pupil);

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final smile = Path();
    smile.moveTo(cx - r * 0.35, cy + r * 0.3);
    smile.quadraticBezierTo(cx, cy + r * 0.65, cx + r * 0.35, cy + r * 0.3);
    canvas.drawPath(smile, smilePaint);
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

    // Blue wavy body
    final bodyPaint = Paint()
      ..color = const Color(0xFF48BFE3) // Light blue
      ..style = PaintingStyle.fill;

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
        final prevRadius = (i - 1).isEven ? r : r * 0.8;
        final prevAngle = ((i - 1) * math.pi / bumps) - (math.pi / 2);
        
        final ctrlX = cx + (r * 1.1) * math.cos((angle + prevAngle) / 2);
        final ctrlY = cy + (r * 1.1) * math.sin((angle + prevAngle) / 2);
        
        path.quadraticBezierTo(ctrlX, ctrlY, x, y);
      }
    }
    path.close();
    canvas.drawPath(path, bodyPaint);

    // Eyes
    final eyeWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final pupil = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx - r * 0.3, cy - r * 0.2), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx - r * 0.25, cy - r * 0.3), r * 0.12, pupil);
    
    canvas.drawCircle(Offset(cx + r * 0.3, cy - r * 0.2), r * 0.25, eyeWhite);
    canvas.drawCircle(Offset(cx + r * 0.25, cy - r * 0.3), r * 0.12, pupil);

    // Sad mouth
    final mouthPaint = Paint()
      ..color = const Color(0xFF242528)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final mouth = Path();
    mouth.moveTo(cx - r * 0.3, cy + r * 0.25);
    mouth.quadraticBezierTo(cx, cy - r * 0.05, cx + r * 0.3, cy + r * 0.25);
    canvas.drawPath(mouth, mouthPaint);

    // Pink Chat Bubble
    final bubblePaint = Paint()
      ..color = const Color(0xFFFF8FAD)
      ..style = PaintingStyle.fill;
    
    final bCx = cx - r * 0.8;
    final bCy = cy - r * 0.8;
    final bR = r * 0.45;

    canvas.drawCircle(Offset(bCx, bCy), bR, bubblePaint);
    final tail = Path();
    tail.moveTo(bCx, bCy + bR * 0.8);
    tail.lineTo(bCx + bR * 0.8, bCy + bR * 0.5);
    tail.lineTo(bCx + bR * 0.4, bCy + bR * 1.2);
    tail.close();
    canvas.drawPath(tail, bubblePaint);

    // Chat bubble dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(bCx - bR * 0.4, bCy), bR * 0.12, dotPaint);
    canvas.drawCircle(Offset(bCx, bCy), bR * 0.12, dotPaint);
    canvas.drawCircle(Offset(bCx + bR * 0.4, bCy), bR * 0.12, dotPaint);

    // Yellow lines
    final linePaint = Paint()
      ..color = const Color(0xFFFDE68A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(cx + r * 0.8, cy - r * 0.9), Offset(cx + r * 0.9, cy - r * 1.1), linePaint);
    canvas.drawLine(Offset(cx + r * 1.1, cy - r * 0.8), Offset(cx + r * 1.3, cy - r * 1.0), linePaint);
    canvas.drawLine(Offset(cx + r * 1.2, cy - r * 0.5), Offset(cx + r * 1.4, cy - r * 0.6), linePaint);
    
    // Bottom Squiggle
    final purpleSquiggle = Paint()
      ..color = const Color(0xFFA287E7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
      
    final sqPath = Path();
    sqPath.moveTo(cx + r * 0.4, cy + r * 0.8);
    sqPath.quadraticBezierTo(cx + r * 1.2, cy + r * 1.2, cx + r * 1.1, cy + r * 0.2);
    sqPath.quadraticBezierTo(cx + r * 0.8, cy - r * 0.2, cx + r * 0.6, cy + r * 0.6);
    canvas.drawPath(sqPath, purpleSquiggle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
