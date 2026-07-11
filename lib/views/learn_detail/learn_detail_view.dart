import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/cards/course_list_item.dart';
import '../../widgets/common/app_primary_button.dart';
import '../../widgets/learn/tag_chip.dart';
import '../../models/course_model.dart';
import '../video_detail/video_detail_view.dart';

class LearnDetailView extends StatelessWidget {
  final CourseModel course;

  const LearnDetailView({
    super.key,
    required this.course,
  });

  static const List<CourseModel> _courses = [
    CourseModel(
      title: 'Taking Out of Stress',
      duration: '6 minutes',
      mood: 'Anxious',
      imagePath: 'assets/images/taking_out_stress.png',
      isLocked: false,
      youtubeVideoId: 'Nz9eAaXRzGg',
    ),
    CourseModel(
      title: 'Taking Breath',
      duration: '6 minutes',
      mood: 'Anxious',
      imagePath: 'assets/images/taking_breath.png',
      isLocked: true,
      youtubeVideoId: 'LiUnFJ8P4gM',
    ),
    CourseModel(
      title: 'Emotional Reacting',
      duration: '6 minutes',
      mood: 'Anxious',
      imagePath: 'assets/images/emotional_reacting.png',
      isLocked: true,
      youtubeVideoId: 'laQIz0hLeII',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: Container(color: AppColors.primaryDeep),
          ),

          // Header Content
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 24),
                        ),
                        const Icon(Icons.more_vert,
                            color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/trauma_childhood.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content Container
          Positioned(
            top: size.height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(200, 40)),
              ),
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 40, left: 16, right: 16, bottom: 24),
                children: [
                  Text(
                    course.title,
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineH3SemiBold(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TagChip(
                          icon: Icons.access_time, label: course.duration),
                      const SizedBox(width: 12),
                      const TagChip(
                          icon: Icons.play_circle_outline, label: 'meditation'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: AppPrimaryButton(
                      label: 'Play Now',
                      width: 150,
                      height: 48,
                      icon: Icons.play_circle_fill,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetailView(
                              fallbackTitle: course.title,
                              videoId: course.youtubeVideoId,
                            ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Mindset Course',
                    style: AppTypography.titleSemiBold(),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(_courses.length, (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CourseListItem(
                      course: _courses[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetailView(
                              fallbackTitle: _courses[i].title,
                              videoId: _courses[i].youtubeVideoId,
                            ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
