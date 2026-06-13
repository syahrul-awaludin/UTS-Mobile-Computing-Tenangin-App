import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onFilterTap;

  const AppSearchBar({
    super.key,
    required this.hintText,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.searchBarBorder, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textCaption, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hintText,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textCaption,
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap ?? () {},
            child: Icon(Icons.tune, color: AppColors.textCaption, size: 24),
          ),
        ],
      ),
    );
  }
}
