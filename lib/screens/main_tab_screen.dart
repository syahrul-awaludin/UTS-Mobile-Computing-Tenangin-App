import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'community_screen.dart';
import 'learn_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0; // Start on Home tab

  final List<Widget> _screens = [
    const HomeScreen(),
    const LearnScreen(),
    const CommunityScreen(),
    const _PlaceholderScreen(title: 'Consult'),
    const _PlaceholderScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textCaption,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home_default.svg', width: 24, height: 24),
              activeIcon: SvgPicture.asset('assets/icons/home_active.svg', width: 24, height: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/learn_default.svg', width: 24, height: 24),
              activeIcon: SvgPicture.asset('assets/icons/learn_active.svg', width: 24, height: 24),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/community_default.svg', width: 24, height: 24),
              activeIcon: SvgPicture.asset('assets/icons/community_active.svg', width: 24, height: 24),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/consult_default.svg', width: 24, height: 24),
              activeIcon: SvgPicture.asset('assets/icons/consult_active.svg', width: 24, height: 24),
              label: 'Consult',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile_default.svg', width: 24, height: 24),
              activeIcon: SvgPicture.asset('assets/icons/profile_active.svg', width: 24, height: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screen for tabs not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: AppColors.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '$title coming soon',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textCaption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
