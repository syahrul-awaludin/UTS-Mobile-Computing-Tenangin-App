import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../services/learn_service.dart';

class LearnController extends ChangeNotifier {
  final LearnService _learnService;

  LearnController(this._learnService) {
    debugPrint('LearnController initialized!');
  }

  String _searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  String get searchQuery => _searchQuery;

  List<CourseModel> get _allCourses => _learnService.fetchAllCourses();

  List<CourseModel> get todayMeditations {
    final list = _learnService.fetchTodayMeditations();
    if (_searchQuery.isEmpty) return list;
    return list
        .where(
          (course) =>
              course.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<CourseModel> get filteredCourses {
    if (_searchQuery.isEmpty) return _allCourses;
    return _allCourses
        .where(
          (course) =>
              course.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
