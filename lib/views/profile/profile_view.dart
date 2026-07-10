import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/profile/achievement_section.dart';
import '../../widgets/profile/avatar_section.dart';
import '../../widgets/profile/mental_progress.dart';
import '../../widgets/profile/welcome_banner.dart';
import 'settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textHeading,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textHeading),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<ProfileController>(
        builder: (context, profileController, _) {
          if (profileController.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          final userName = profileController.userData?['name'] ?? 'name';

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                // 1. Avatar Section
                AvatarSection(userName: userName),
                const SizedBox(height: 32),

                // 2. Welcome Banner
                const WelcomeBanner(),
                const SizedBox(height: 32),

                // 3. Mental Progress
                const MentalProgress(),
                const SizedBox(height: 32),

                // 4. Achievement
                const AchievementSection(),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
}
}
