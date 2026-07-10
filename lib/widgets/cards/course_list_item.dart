import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/course_model.dart';

/// A list item card used in vertical course/meditation lists
class CourseListItem extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseListItem({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(course.imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.play_circle_outline,
                          size: 14, color: AppColors.textCaption),
                      const SizedBox(width: 4),
                      Text(course.duration,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textCaption)),
                      if (course.mood.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.favorite_border,
                            size: 14, color: AppColors.textCaption),
                        const SizedBox(width: 4),
                        Text(course.mood,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textCaption)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
