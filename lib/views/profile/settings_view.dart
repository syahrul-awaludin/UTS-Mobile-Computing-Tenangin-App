import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/profile/settings_list_item.dart';
import '../splash/splash_view.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final userProfile = authController.userProfile;
    final userName = userProfile != null && userProfile['name'] != null 
        ? userProfile['name'] 
        : 'User Name';
    final userEmail = userProfile != null && userProfile['email'] != null 
        ? userProfile['email'] 
        : '@username';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.textHeading,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textHeading),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 7.5,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Avatar
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      // Name & Handle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.textHeading,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              userEmail,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: AppColors.textCaption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Security Section
            const Text(
              'Security',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textHeading,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    spreadRadius: -3,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SettingsListItem(
                    icon: Icons.notifications_none,
                    title: 'Notification',
                  ),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SettingsListItem(
                    icon: Icons.lock_outline,
                    title: 'Password',
                  ),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SettingsListItem(
                    icon: Icons.language,
                    title: 'Language',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Section
            const Text(
              'Account',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textHeading,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    spreadRadius: -3,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SettingsListItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      // Tetap ada namun screen-nya tidak ada, sesuai request
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SettingsListItem(
                    icon: Icons.link,
                    title: 'Linked Accounts',
                  ),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SettingsListItem(
                    icon: Icons.remove_red_eye_outlined,
                    title: 'Privacy Settings',
                  ),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  SettingsListItem(
                    icon: Icons.logout,
                    title: 'Log Out',
                    isDestructive: true,
                    onTap: () {
                      context.read<AuthController>().logout(context, () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SplashView()),
                          (route) => false,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

}
