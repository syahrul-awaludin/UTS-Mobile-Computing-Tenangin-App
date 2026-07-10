import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../painters/character_painter.dart';

/// The purple greeting banner on the Home screen
class GreetingBanner extends StatelessWidget {
  final String userName;
  final VoidCallback? onAddMood;

  const GreetingBanner({super.key, required this.userName, this.onAddMood});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        color: const Color(0xFF4D22B5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Decorative squiggles
          Positioned(
            top: 15,
            right: 15,
            child: SizedBox(
              width: 30,
              height: 20,
              child: CustomPaint(
                painter: SquigglePainter(color: AppColors.primaryLight),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 60,
            child: SizedBox(
              width: 30,
              height: 30,
              child: CustomPaint(
                painter: SquigglePainter(color: AppColors.primaryLight),
              ),
            ),
          ),
          // Character illustration
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Home_Illustration.png',
              height: 140,
              fit: BoxFit.contain,
            ),
          ),
          // Content
          // Content
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0, right: 120.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_getGreeting()}, $userName',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onAddMood,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3BEC),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Add Mood',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
