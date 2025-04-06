import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Display (for large display text)
  static const TextStyle display = TextStyle(
    fontFamily: 'Geist',
    fontSize: 44,
    fontWeight: FontWeight.w500,
    height: 1.09,
    color: AppColors.textPrimary,
  );

  // Headings (H1 to H6)
  static const TextStyle headingH1 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.22,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingH2 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingH3 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.29,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingH4 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingH5 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingH6 = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.33,
    color: AppColors.textPrimary,
  );

  // Paragraphs
  static const TextStyle paragraphLarge = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.56,
    color: AppColors.textPrimary,
  );

  static const TextStyle paragraphMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle paragraphSmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle paragraphXSmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.67,
    color: AppColors.surface,
  );

  // Labels
  static final TextStyle overline = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 0.86,
    color: AppColors.textSecondary.withOpacity(0.7),
  );

  static final TextStyle button = TextStyle(
    fontFamily: 'Geist',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Error Text
  static const TextStyle error = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.danger,
  );
}
