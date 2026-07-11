import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MentalProgress extends StatelessWidget {
  const MentalProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MENTAL PROGRESS',
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
            _buildPillButton('Anxiety', const Color(0xFF1FE5B9)),
            const SizedBox(width: 12),
            _buildPillButton('Stress', const Color(0xFF3F089D)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar('S', 0.4, const Color(0xFFFFC663)),
              _buildBar('M', 0.6, const Color(0xFFFFC663)),
              _buildBar('T', 0.0, AppColors.background),
              _buildBar('W', 0.8, const Color(0xFFFFC663)),
              _buildBar('T', 0.0, AppColors.background),
              _buildBar('F', 0.0, AppColors.background),
              _buildBar('S', 0.0, AppColors.background),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPillButton(String text, Color dotColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: AppColors.textHeading,
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 12,
          height: 140 * heightFactor > 0
              ? 140 * heightFactor
              : 10, // Min height
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 14,
            color: AppColors.textHeading,
          ),
        ),
      ],
    );
  }
}
