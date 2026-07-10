import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TagChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const TagChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textHeading),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 14, color: AppColors.textHeading)),
        ],
      ),
    );
  }
}
