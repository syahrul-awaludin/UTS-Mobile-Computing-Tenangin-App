import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/profile/avatar_section.dart';
import '../auth/login_view.dart';

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
        title: Text('Profile', style: AppTypography.headlineH1Bold()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.moodStress),
            onPressed: () {
              context.read<AuthController>().logout(context, () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (route) => false,
                );
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<ProfileController>(
        builder: (context, profileController, _) {
          if (profileController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final userName = profileController.userData?['name'] ?? 'name';

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              children: [
                // 1. Avatar Section
                AvatarSection(userName: userName),

                // 2. Coming Soon Placeholder (Centered)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.construction,
                          size: 64,
                          color: AppColors.primary.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Profile coming soon',
                          style: AppTypography.titleMedium(
                            color: AppColors.textCaption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
