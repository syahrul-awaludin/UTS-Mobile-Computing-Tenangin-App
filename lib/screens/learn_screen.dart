import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/character_painter.dart';
import '../widgets/search_bar_widget.dart';
import 'learn_detail_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Taking Out of Stress',
      'duration': '6 minutes',
      'mood': 'Anxious',
      'imagePath': 'assets/images/taking_out_stress.png',
      'isLocked': false,
    },
    {
      'title': 'Taking Breath',
      'duration': '6 minutes',
      'mood': 'Anxious',
      'imagePath': 'assets/images/taking_breath.png',
      'isLocked': true,
    },
    {
      'title': 'Mindfullness',
      'duration': '6 minutes',
      'mood': 'Anxious',
      'imagePath': 'assets/images/mindfullnes.png',
      'isLocked': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter the courses based on search query
    final filteredCourses = _courses.where((course) {
      return course['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Learn',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textHeading,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Using standard TextField wrapped to look like AppSearchBar
          // Because AppSearchBar wasn't originally stateful.
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.searchBarBorder, width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textCaption, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'What do you want to learn?',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.textCaption,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.tune, color: AppColors.textCaption, size: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildTodayMeditation(),
          const SizedBox(height: 32),
          
          // Mindset Course List (Filtered)
          const Text(
            'Mindset Course',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 16),
          if (filteredCourses.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  'No courses found.',
                  style: TextStyle(color: AppColors.textCaption),
                ),
              ),
            )
          else
            ...filteredCourses.map((course) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildCourseItem(
                  course['title'],
                  course['duration'],
                  course['mood'],
                  course['imagePath'],
                  course['isLocked'],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildTodayMeditation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Meditation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 222,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildMeditationCard(
                'Taking Breath',
                '6 minutes',
                'assets/images/taking_breath.png',
                isLocked: true,
              ),
              const SizedBox(width: 16),
              _buildMeditationCard(
                'Mindfullness',
                '6 minutes',
                'assets/images/mindfullnes.png',
                isLocked: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMeditationCard(
      String title, String duration, String imagePath,
      {required bool isLocked}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LearnDetailScreen()),
        );
      },
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
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLocked)
                  const Icon(Icons.lock_outline, size: 20, color: AppColors.textHeading),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.play_circle_outline, size: 14, color: AppColors.textCaption),
                const SizedBox(width: 4),
                Text(duration, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(
      String title, String duration, String mood, String imagePath, bool isLocked) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LearnDetailScreen()),
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
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.play_circle_outline, size: 14, color: AppColors.textCaption),
                      const SizedBox(width: 4),
                      Text(duration, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
                      const SizedBox(width: 12),
                      const Icon(Icons.favorite_border, size: 14, color: AppColors.textCaption),
                      const SizedBox(width: 4),
                      Text(mood, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
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
