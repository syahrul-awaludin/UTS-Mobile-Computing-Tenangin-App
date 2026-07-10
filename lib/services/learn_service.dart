import '../models/course_model.dart';

class LearnService {
  List<CourseModel> fetchAllCourses() {
    return const [
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
        title: 'Mindfullness',
        duration: '6 minutes',
        mood: 'Anxious',
        imagePath: 'assets/images/mindfullnes.png',
        isLocked: true,
        youtubeVideoId: 'laQIz0hLeII',
      ),
    ];
  }

  List<CourseModel> fetchTodayMeditations() {
    return const [
      CourseModel(
        title: 'Taking Breath',
        duration: '6 minutes',
        mood: 'Anxious',
        imagePath: 'assets/images/taking_breath.png',
        isLocked: true,
        youtubeVideoId: 'LiUnFJ8P4gM',
      ),
      CourseModel(
        title: 'Mindfullness',
        duration: '6 minutes',
        mood: 'Anxious',
        imagePath: 'assets/images/mindfullnes.png',
        isLocked: false,
        youtubeVideoId: 'laQIz0hLeII',
      ),
    ];
  }
}
