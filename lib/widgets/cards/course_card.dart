import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../models/course_model.dart';

/// A card used in horizontal scroll lists (Today's Meditation, Personality Tests)
class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseCard({super.key, required this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 206,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(course.imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            // Title row with optional lock icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    course.title,
                    style: AppTypography.titleSemiBold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (course.isLocked)
                  const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: AppColors.textHeading,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            // Metadata row
            Row(
              children: [
                const Icon(
                  Icons.play_circle_outline,
                  size: 14,
                  color: AppColors.textCaption,
                ),
                const SizedBox(width: 4),
                Text(
                  course.duration,
                  style: AppTypography.smallDescriptionRegular(
                    color: AppColors.textCaption,
                  ).copyWith(fontSize: 12),
                ),
                if (course.mood.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.article_outlined,
                    size: 14,
                    color: AppColors.textCaption,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    course.mood,
                    style: AppTypography.smallDescriptionRegular(
                      color: AppColors.textCaption,
                    ).copyWith(fontSize: 12),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
