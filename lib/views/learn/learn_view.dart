import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/learn_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/cards/course_list_item.dart';
import '../../widgets/common/app_search_bar.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/learn/today_meditation_list.dart';
import '../learn_detail/learn_detail_view.dart';

class LearnView extends StatefulWidget {
  const LearnView({super.key});

  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  @override
  Widget build(BuildContext context) {
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
      body: Consumer<LearnController>(
        builder: (context, controller, _) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              AppSearchBar(
                controller: controller.searchController,
                hintText: 'What do you want to learn?',
                onChanged: controller.updateSearch,
              ),
              const SizedBox(height: 24),
              TodayMeditationList(todayMeditations: controller.todayMeditations),
              const SizedBox(height: 32),
              SectionHeader(title: 'Mindset Course'),
              const SizedBox(height: 16),
              if (controller.filteredCourses.isEmpty)
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
                ...List.generate(controller.filteredCourses.length, (i) {
                  final course = controller.filteredCourses[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CourseListItem(
                      course: course,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LearnDetailView(course: course)),
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
