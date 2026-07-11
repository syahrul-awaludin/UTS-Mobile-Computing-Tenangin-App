import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../home/home_view.dart';
import '../learn/learn_view.dart';
import '../community/community_view.dart';
import '../profile/profile_view.dart';

import 'package:provider/provider.dart';
import '../../services/socket_service.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const LearnView(),
    const CommunityView(),
    const _PlaceholderView(title: 'Consult'),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SocketService>().connectAndListen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
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
          unselectedItemColor: const Color(0xFFCDCFD4),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home_default.svg',
                width: 24,
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home_active.svg',
                width: 24,
                height: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/learn_default.svg',
                width: 24,
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/learn_active.svg',
                width: 24,
                height: 24,
              ),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/community_default.svg',
                width: 24,
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/community_active.svg',
                width: 24,
                height: 24,
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/consult_default.svg',
                width: 24,
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/consult_active.svg',
                width: 24,
                height: 24,
              ),
              label: 'Consult',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile_default.svg',
                width: 24,
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/profile_active.svg',
                width: 24,
                height: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String title;
  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
              color: AppColors.primary.withValues(alpha: 0.5),
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
