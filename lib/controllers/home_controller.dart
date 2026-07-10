import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../models/course_model.dart';

import '../services/home_service.dart';

class HomeController extends ChangeNotifier {
  final HomeService _homeService;

  HomeController(this._homeService) {
    _moodHistory = _homeService.fetchMoodHistory();
    _personalityTests = _homeService.fetchPersonalityTests();
    final userSummary = _homeService.fetchUserSummary();
    _userName = userSummary['userName'];
    _streakCount = userSummary['streakCount'];
    _dailyAffirmation = userSummary['dailyAffirmation'];
  }

  int _selectedDateIndex = 10;
  int get selectedDateIndex => _selectedDateIndex;

  void selectDate(int index) {
    if (_selectedDateIndex != index) {
      _selectedDateIndex = index;
      notifyListeners();
    }
  }

  late List<MoodModel> _moodHistory;
  late List<CourseModel> _personalityTests;
  late String _dailyAffirmation;
  late String _userName;
  late int _streakCount;

  List<MoodModel> get moodHistory => _moodHistory;
  List<CourseModel> get personalityTests => _personalityTests;
  String get dailyAffirmation => _dailyAffirmation;
  String get userName => _userName;
  int get streakCount => _streakCount;
}
