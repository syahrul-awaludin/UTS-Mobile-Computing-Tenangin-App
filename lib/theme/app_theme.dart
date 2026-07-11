import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTypography.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textHeading),
        titleTextStyle: AppTypography.headlineH1Bold(
          color: AppColors.textHeading,
        ).copyWith(fontSize: 24),
      ),
      textTheme: TextTheme(
        // H1 — screen titles
        displayLarge: AppTypography.headlineH1Bold(),
        // Section titles
        titleLarge: AppTypography.titleSemiBold(),
        // Card titles
        titleMedium: AppTypography.body1SemiBold(),
        // Body text
        bodyLarge: AppTypography.body1Regular(),
        bodyMedium: AppTypography.body2Regular(),
        // Caption
        labelSmall: AppTypography.smallDescriptionRegular(
          color: AppColors.textCaption,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          textStyle: AppTypography.body1SemiBold(),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        hintStyle: AppTypography.body1Regular(color: AppColors.textCaption),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.surface,
      ),
    );
  }
}
