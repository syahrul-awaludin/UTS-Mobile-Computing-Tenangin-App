import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/home/greeting_banner.dart';
import '../../widgets/home/date_selector.dart';
import '../../widgets/home/daily_affirmation.dart';
import '../../widgets/home/streak_badge.dart';
import '../../widgets/home/mood_history_list.dart';
import '../../widgets/home/personality_tests_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        final authController = context.watch<AuthController>();
        final userName = authController.userProfile?['name'] ?? 'User';
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Image.asset('assets/images/Logo_Primary.png', height: 28),
            centerTitle: false,
            actions: [
              StreakBadge(count: controller.streakCount),
              const SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                DateSelector(
                  selectedIndex: controller.selectedDateIndex,
                  onDateSelected: controller.selectDate,
                ),
                const SizedBox(height: 24),
                GreetingBanner(userName: userName),
                const SizedBox(height: 24),
                MoodHistoryList(moodHistory: controller.moodHistory),
                const SizedBox(height: 32),
                PersonalityTestsSection(
                  personalityTests: controller.personalityTests,
                ),
                const SizedBox(height: 32),
                SectionHeader(title: 'Daily Affirmation'),
                const SizedBox(height: 16),
                DailyAffirmation(
                  quote: controller.dailyAffirmation,
                  onShare: () {},
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
