import '../models/mood_model.dart';
import '../models/course_model.dart';
import '../theme/app_colors.dart';

class HomeService {
  // Simulating an API call to get mood history
  List<MoodModel> fetchMoodHistory() {
    return const [
      MoodModel(
        date: '11 Juni 2025',
        feeling: "I'm Feeling Good",
        moodColor: AppColors.moodHappy,
        expression: MoodExpression.happy,
      ),
      MoodModel(
        date: '10 Juni 2025',
        feeling: "I'm Feeling Anxious",
        moodColor: AppColors.moodAnxious,
        expression: MoodExpression.neutral,
      ),
      MoodModel(
        date: '9 Juni 2025',
        feeling: "I'm Feeling Stress",
        moodColor: AppColors.moodStress,
        expression: MoodExpression.sad,
      ),
    ];
  }

  // Simulating an API call to get personality tests
  List<CourseModel> fetchPersonalityTests() {
    return const [
      CourseModel(
        title: 'Childhood Trauma',
        duration: '10 mins',
        mood: '20 questions',
        imagePath: 'assets/images/trauma_childhood.png',
      ),
      CourseModel(
        title: 'Emotional Intelligence',
        duration: '15 mins',
        mood: '30 questions',
        imagePath: 'assets/images/emotional_inteligence.png',
      ),
      CourseModel(
        title: 'Emotional Intelligence',
        duration: '15 mins',
        mood: '30 questions',
        imagePath: 'assets/images/emotional_inteligence.png',
      ),
    ];
  }

  // Simulating fetching user data
  Map<String, dynamic> fetchUserSummary() {
    return {
      'userName': 'Sarah',
      'streakCount': 12,
      'dailyAffirmation': 'Be Honest and Powerfull as Yourself',
    };
  }
}
