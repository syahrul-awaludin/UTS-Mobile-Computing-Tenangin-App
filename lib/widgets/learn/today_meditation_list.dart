import 'package:flutter/material.dart';
import '../../models/course_model.dart';
import '../cards/course_card.dart';
import '../common/section_header.dart';
import '../../views/learn_detail/learn_detail_view.dart';

class TodayMeditationList extends StatelessWidget {
  final List<CourseModel> todayMeditations;

  const TodayMeditationList({super.key, required this.todayMeditations});

  @override
  Widget build(BuildContext context) {
    if (todayMeditations.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Today's Meditation"),
        const SizedBox(height: 16),
        SizedBox(
          height: 222,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: todayMeditations.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return CourseCard(
                course: todayMeditations[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LearnDetailView(course: todayMeditations[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
