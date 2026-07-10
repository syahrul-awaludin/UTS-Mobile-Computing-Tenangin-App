import 'package:flutter/material.dart';

enum MoodExpression { happy, neutral, sad }

class MoodModel {
  final String date;
  final String feeling;
  final Color moodColor;
  final MoodExpression expression;

  const MoodModel({
    required this.date,
    required this.feeling,
    required this.moodColor,
    this.expression = MoodExpression.happy,
  });
}
