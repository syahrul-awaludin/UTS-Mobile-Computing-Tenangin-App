import 'package:flutter/material.dart';
import '../../models/mood_model.dart';
import '../cards/mood_card.dart';

class MoodHistoryList extends StatelessWidget {
  final List<MoodModel> moodHistory;

  const MoodHistoryList({super.key, required this.moodHistory});

  @override
  Widget build(BuildContext context) {
    if (moodHistory.isEmpty) return const SizedBox();

    return Column(
      children: moodHistory
          .expand((mood) => [
                MoodCard(
                  date: mood.date,
                  feeling: mood.feeling,
                  moodColor: mood.moodColor,
                  expression: mood.expression,
                ),
                const SizedBox(height: 12),
              ])
          .toList()
        ..removeLast(),
    );
  }
}
