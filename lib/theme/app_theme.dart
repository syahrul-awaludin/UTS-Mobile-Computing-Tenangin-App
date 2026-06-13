import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textHeading),
        titleTextStyle: TextStyle(
          color: AppColors.textHeading,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        // H1 — screen titles
        displayLarge: TextStyle(
          color: AppColors.textHeading,
          fontSize: 25,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          height: 1.6,
        ),
        // Section titles
        titleLarge: TextStyle(
          color: AppColors.textHeading,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        // Card titles
        titleMedium: TextStyle(
          color: AppColors.textHeading,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        // Body text
        bodyLarge: TextStyle(
          color: AppColors.textHeading,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          color: AppColors.textHeading,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
        // Caption
        labelSmall: TextStyle(
          color: AppColors.textCaption,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.surface,
      ),
    );
  }
}
