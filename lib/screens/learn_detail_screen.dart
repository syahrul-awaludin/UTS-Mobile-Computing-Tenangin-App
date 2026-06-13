import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/character_painter.dart';
import 'video_detail_screen.dart';
import 'content_detail_screen.dart';

class LearnDetailScreen extends StatelessWidget {
  final String title;
  final String mood;
  final String duration;

  const LearnDetailScreen({
    super.key,
    this.title = 'Trauma Childhood',
    this.mood = 'Anxious',
    this.duration = '6 min',
  });

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
            child: Container(
              color: AppColors.primaryDeep,
            ),
          ),
          
          // Header Content (Sad Character & AppBar icons)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: SafeArea(
              child: Stack(
                children: [
                  // App Bar icons
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                        ),
                        const Icon(Icons.more_vert, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                  
                  // Main Illustration
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

          // Main Content Container (White rounded section)
          Positioned(
            top: size.height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(200, 40),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 24),
                children: [
                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHeading,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Tags (6 min & meditation)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTag(Icons.access_time, duration),
                      const SizedBox(width: 12),
                      _buildTag(Icons.play_circle_outline, 'meditation'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Play Now Button
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VideoDetailScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_circle_fill, size: 20),
                        label: const Text('Play Now', style: TextStyle(fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Mindset Course List
                  const Text(
                    'Mindset Course',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHeading,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCourseItem('Taking Out of Stress', '6 minutes', 'Anxious', 'assets/images/taking_out_stress.png', false, context),
                  const SizedBox(height: 12),
                  _buildCourseItem('Taking Breath', '6 minutes', 'Anxious', 'assets/images/taking_breath.png', true, context),
                  const SizedBox(height: 12),
                  _buildCourseItem('Emotional Reacting', '6 minutes', 'Anxious', 'assets/images/emotional_reacting.png', true, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white, // Match surface color
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textHeading),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.textHeading),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem(String courseTitle, String courseDuration, String courseMood, String imagePath, bool isLocked, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VideoDetailScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseTitle,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.play_circle_outline, size: 14, color: AppColors.textCaption),
                      const SizedBox(width: 4),
                      Text(courseDuration, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
                      const SizedBox(width: 12),
                      const Icon(Icons.favorite_border, size: 14, color: AppColors.textCaption),
                      const SizedBox(width: 4),
                      Text(courseMood, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
                    ],
                  ),
                ],
              ),
            ),
            if (isLocked)
              const Icon(Icons.lock_outline, color: AppColors.textHeading, size: 24),
          ],
        ),
      ),
    );
  }
}
