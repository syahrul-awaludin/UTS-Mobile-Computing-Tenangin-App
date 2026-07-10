import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';

/// Social login button (Google, Apple, Facebook)
class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(assetPath, width: 24, height: 24),
        ),
      ),
    );
  }
}
