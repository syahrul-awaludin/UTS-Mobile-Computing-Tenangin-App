import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/mood_model.dart';

class MoodCard extends StatelessWidget {
  final String date;
  final String feeling;
  final Color moodColor;
  final MoodExpression expression;

  const MoodCard({
    super.key,
    required this.date,
    required this.feeling,
    required this.moodColor,
    this.expression = MoodExpression.happy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              if (constraints.maxWidth > 100) _buildMoodIcon(),
              if (constraints.maxWidth > 100) const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textCaption,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      feeling,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textHeading,
                      ),
                    ),
                  ],
                ),
              ),
              if (constraints.maxWidth > 60)
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColors.textCaption,
                    size: 24,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMoodIcon() {
    String imagePath;
    switch (expression) {
      case MoodExpression.happy:
        imagePath = 'assets/images/good.png';
        break;
      case MoodExpression.neutral:
        imagePath = 'assets/images/anxious.png';
        break;
      case MoodExpression.sad:
        imagePath = 'assets/images/stress.png';
        break;
    }
    return SizedBox(
      width: 52,
      height: 52,
      child: Image.asset(imagePath),
    );
  }
}
