import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppTypography defines the standard typography system for the application.
/// It uses the 'Inter' font family by default and provides constants for
/// all text sizes and weights specified in the design system.
class AppTypography {
  static const String fontFamily = 'Inter';

  static TextStyle _base(
    double size,
    FontWeight weight,
    double? height, {
    Color color = AppColors.textHeading,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  // ==========================================
  // Headline H1 (Size: 25, Height: 1.6)
  // ==========================================
  static TextStyle headlineH1Bold({Color color = AppColors.textHeading}) =>
      _base(25, FontWeight.w700, 1.6, color: color);
  static TextStyle headlineH1SemiBold({Color color = AppColors.textHeading}) =>
      _base(25, FontWeight.w600, 1.6, color: color);
  static TextStyle headlineH1Medium({Color color = AppColors.textHeading}) =>
      _base(25, FontWeight.w500, 1.6, color: color);
  static TextStyle headlineH1Regular({Color color = AppColors.textHeading}) =>
      _base(25, FontWeight.w400, 1.6, color: color);

  // ==========================================
  // Headline H2 (Size: 23, Height: 1.5)
  // ==========================================
  static TextStyle headlineH2Bold({Color color = AppColors.textHeading}) =>
      _base(23, FontWeight.w700, 1.5, color: color);
  static TextStyle headlineH2SemiBold({Color color = AppColors.textHeading}) =>
      _base(23, FontWeight.w600, 1.5, color: color);
  static TextStyle headlineH2Medium({Color color = AppColors.textHeading}) =>
      _base(23, FontWeight.w500, 1.5, color: color);
  static TextStyle headlineH2Regular({Color color = AppColors.textHeading}) =>
      _base(23, FontWeight.w400, 1.5, color: color);

  // ==========================================
  // Headline H3 (Size: 20, Height: 1.5)
  // ==========================================
  static TextStyle headlineH3Bold({Color color = AppColors.textHeading}) =>
      _base(20, FontWeight.w700, 1.5, color: color);
  static TextStyle headlineH3SemiBold({Color color = AppColors.textHeading}) =>
      _base(20, FontWeight.w600, 1.5, color: color);
  static TextStyle headlineH3Medium({Color color = AppColors.textHeading}) =>
      _base(20, FontWeight.w500, 1.5, color: color);
  static TextStyle headlineH3Regular({Color color = AppColors.textHeading}) =>
      _base(20, FontWeight.w400, 1.5, color: color);

  // ==========================================
  // Sub Heading (Size: 19, Height: 1.4)
  // ==========================================
  static TextStyle subHeadingBold({Color color = AppColors.textHeading}) =>
      _base(19, FontWeight.w700, 1.4, color: color);
  static TextStyle subHeadingSemiBold({Color color = AppColors.textHeading}) =>
      _base(19, FontWeight.w600, 1.4, color: color);
  static TextStyle subHeadingMedium({Color color = AppColors.textHeading}) =>
      _base(19, FontWeight.w500, 1.4, color: color);
  static TextStyle subHeadingRegular({Color color = AppColors.textHeading}) =>
      _base(19, FontWeight.w400, 1.4, color: color);

  // ==========================================
  // Title (Size: 17, Height: 1.4)
  // ==========================================
  static TextStyle titleBold({Color color = AppColors.textHeading}) =>
      _base(17, FontWeight.w700, 1.4, color: color);
  static TextStyle titleSemiBold({Color color = AppColors.textHeading}) =>
      _base(17, FontWeight.w600, 1.4, color: color);
  static TextStyle titleMedium({Color color = AppColors.textHeading}) =>
      _base(17, FontWeight.w500, 1.4, color: color);
  static TextStyle titleRegular({Color color = AppColors.textHeading}) =>
      _base(17, FontWeight.w400, 1.4, color: color);

  // ==========================================
  // Body 1 (Size: 15, Height: null/auto)
  // ==========================================
  static TextStyle body1Bold({Color color = AppColors.textHeading}) =>
      _base(15, FontWeight.w700, null, color: color);
  static TextStyle body1SemiBold({Color color = AppColors.textHeading}) =>
      _base(15, FontWeight.w600, null, color: color);
  static TextStyle body1Medium({Color color = AppColors.textHeading}) =>
      _base(15, FontWeight.w500, null, color: color);
  static TextStyle body1Regular({Color color = AppColors.textHeading}) =>
      _base(15, FontWeight.w400, null, color: color);

  // ==========================================
  // Body 2 (Size: 14, Height: 1.3)
  // ==========================================
  static TextStyle body2Bold({Color color = AppColors.textHeading}) =>
      _base(14, FontWeight.w700, 1.3, color: color);
  static TextStyle body2SemiBold({Color color = AppColors.textHeading}) =>
      _base(14, FontWeight.w600, 1.3, color: color);
  static TextStyle body2Medium({Color color = AppColors.textHeading}) =>
      _base(14, FontWeight.w500, 1.3, color: color);
  static TextStyle body2Regular({Color color = AppColors.textHeading}) =>
      _base(14, FontWeight.w400, 1.3, color: color);

  // ==========================================
  // Description (Size: 13, Height: 1.3)
  // ==========================================
  static TextStyle descriptionBold({Color color = AppColors.textHeading}) =>
      _base(13, FontWeight.w700, 1.3, color: color);
  static TextStyle descriptionSemiBold({Color color = AppColors.textHeading}) =>
      _base(13, FontWeight.w600, 1.3, color: color);
  static TextStyle descriptionMedium({Color color = AppColors.textHeading}) =>
      _base(13, FontWeight.w500, 1.3, color: color);
  static TextStyle descriptionRegular({Color color = AppColors.textHeading}) =>
      _base(13, FontWeight.w400, 1.3, color: color);

  // ==========================================
  // Small Description (Size: 10, Height: null/auto)
  // ==========================================
  static TextStyle smallDescriptionBold({
    Color color = AppColors.textHeading,
  }) => _base(10, FontWeight.w700, null, color: color);
  static TextStyle smallDescriptionSemiBold({
    Color color = AppColors.textHeading,
  }) => _base(10, FontWeight.w600, null, color: color);
  static TextStyle smallDescriptionMedium({
    Color color = AppColors.textHeading,
  }) => _base(10, FontWeight.w500, null, color: color);
  static TextStyle smallDescriptionRegular({
    Color color = AppColors.textHeading,
  }) => _base(10, FontWeight.w400, null, color: color);
}
