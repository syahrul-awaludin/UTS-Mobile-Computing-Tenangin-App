class CourseModel {
  final String title;
  final String duration;
  final String mood;
  final String imagePath;
  final bool isLocked;
  final String youtubeVideoId;

  const CourseModel({
    required this.title,
    required this.duration,
    required this.mood,
    required this.imagePath,
    this.isLocked = false,
    this.youtubeVideoId = 'dQw4w9WgXcQ',
  });
}
