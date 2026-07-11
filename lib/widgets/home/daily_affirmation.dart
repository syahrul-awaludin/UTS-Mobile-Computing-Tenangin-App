import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Daily affirmation quote card with share button
class DailyAffirmation extends StatelessWidget {
  final String quote;
  final VoidCallback? onShare;

  const DailyAffirmation({super.key, required this.quote, this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Image.asset('assets/images/Logo_Primary.png', height: 28),
          const SizedBox(height: 32),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textHeading,
                    height: 1.3,
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                child: Text(
                  '"',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 64,
                    color: AppColors.textHeading,
                    height: 0.8,
                  ),
                ),
              ),
              const Positioned(
                bottom: -10,
                right: 0,
                child: Text(
                  '"',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 64,
                    color: AppColors.textHeading,
                    height: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: onShare,
              icon: const Icon(Icons.ios_share, color: Colors.white),
              label: const Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySoft,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
