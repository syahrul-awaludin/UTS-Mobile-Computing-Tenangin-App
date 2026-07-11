import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ACHIEVEMENT',
          style: TextStyle(
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: AppColors.textHeading,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildAchievementCard(progress: 1.0)),
            const SizedBox(width: 16),
            Expanded(child: _buildAchievementCard(progress: 0.5)),
            const SizedBox(width: 16),
            Expanded(child: _buildAchievementCard(progress: 0.1)),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementCard({required double progress}) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  size: 16,
                  color: progress == 1.0 ? AppColors.primary : Colors.grey[400],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Starter',
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Complete',
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 12,
              color: AppColors.textCaption,
            ),
          ),
        ],
      ),
    );
  }
}
