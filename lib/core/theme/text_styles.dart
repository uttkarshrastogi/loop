// lib/core/theme/text_styles.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Display    (for large display text)
  static const TextStyle display = TextStyle(
    fontFamily: 'Geist',
    fontSize: 44,
    fontWeight: FontWeight.w500,
    height: 1.09, // Line height of 48px
    color: AppColors.neutral800,
  );

  // Headings (H1, H2, H3, etc.)
  static const TextStyle headingH1 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.22, // Line height of 44px
    color: AppColors.neutral800,
  );

  static const TextStyle headingH2 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25, // Line height of 40px
    color: AppColors.neutral800,
  );

  static const TextStyle headingH3 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.29, // Line height of 36px
    color: AppColors.neutral800,
  );

  static const TextStyle headingH4 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33, // Line height of 32px
    color: AppColors.neutral800,
  );

  static const TextStyle headingH5 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4, // Line height of 28px
    color: AppColors.neutral800,
  );

  static const TextStyle headingH6 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.33, // Line height of 24px
    color: AppColors.neutral800,
  );

  // Paragraph Styles
  static const TextStyle paragraphLarge = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.56, // Line height of 28px
    color: AppColors.neutral800,
  );

  static const TextStyle paragraphMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5, // Line height of 24px
    color: AppColors.neutral800,
  );

  static const TextStyle paragraphSmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43, // Line height of 20px
    color: AppColors.neutral800,
  );

  static const TextStyle paragraphXSmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.67, // Line height of 20px
    color: AppColors.neutral800,
  );

  // Additional Styles
  static final TextStyle overline = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 0.86, // Line height of 12px
    color: AppColors.neutral800.withOpacity(0.7),
  );

  static final TextStyle button =  TextStyle(
    fontFamily: 'Geist',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.blue600,
  );

  // Error Text
  static const TextStyle error = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.red500,
  );
}
