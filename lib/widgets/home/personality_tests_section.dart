import 'package:flutter/material.dart';
import '../../models/course_model.dart';
import '../cards/course_card.dart';
import '../common/section_header.dart';

class PersonalityTestsSection extends StatelessWidget {
  final List<CourseModel> personalityTests;

  const PersonalityTestsSection({super.key, required this.personalityTests});

  @override
  Widget build(BuildContext context) {
    if (personalityTests.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Personalities Test'),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: personalityTests.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return CourseCard(course: personalityTests[index], onTap: () {});
            },
          ),
        ),
      ],
    );
  }
}
