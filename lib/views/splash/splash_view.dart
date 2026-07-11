import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../onboarding/onboarding_view.dart';
import '../main_tab/main_tab_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _showGradient = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _showGradient = true);
        _controller.forward();
      }
    });

    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for the splash animation to show
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    final authController = context.read<AuthController>();
    final isLoggedIn = await authController.checkLoginStatus();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) =>
              isLoggedIn ? const MainTabView() : const OnboardingView(),
          transitionsBuilder: (_, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: _showGradient
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF7B5CE8),
                    Color(0xFF9B7EF8),
                    Color(0xFFB98DF7),
                  ],
                )
              : const LinearGradient(
                  colors: [AppColors.background, AppColors.background],
                ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset('assets/images/Tenangin_Logo.png'),
          ),
        ),
      ),
    );
  }
}
