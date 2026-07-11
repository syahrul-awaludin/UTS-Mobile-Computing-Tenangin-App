import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AvatarSection extends StatelessWidget {
  final String userName;

  const AvatarSection({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF5D29D8), // Primary/700
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.person, color: Colors.white, size: 50),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.camera_alt, size: 16, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          userName,
          style: AppTypography.subHeadingSemiBold(),
        ),
      ],
    );
  }
}
