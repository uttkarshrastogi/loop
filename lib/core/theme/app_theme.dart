// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:loop/core/theme/spacing.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Geist',
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTextStyles.paragraphLarge.copyWith(color: AppColors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: AppColors.textPrimary,
      ),
      primaryColor: AppColors.background,
      hintColor: AppColors.textSecondary,
      scaffoldBackgroundColor: AppColors.textPrimary,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.success,
        onSecondary: AppColors.primary,
        surface: AppColors.textPrimary,
        onSurface: AppColors.primary,
        error: AppColors.danger,
        onError: AppColors.textPrimary,
        background: AppColors.surface,
        onBackground: AppColors.background,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing4,
          horizontal: AppSpacing.spacing6,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display, // Display text
        headlineLarge: AppTextStyles.headingH1, // H1 Heading
        headlineMedium: AppTextStyles.headingH2, // H2 Heading
        headlineSmall: AppTextStyles.headingH3, // H3 Heading
        titleLarge: AppTextStyles.headingH4, // H4 Heading
        titleMedium: AppTextStyles.headingH5, // H5 Heading
        titleSmall: AppTextStyles.headingH6, // H6 Heading
        bodyLarge: AppTextStyles.paragraphLarge, // Large paragraph text
        bodyMedium: AppTextStyles.paragraphMedium, // Medium paragraph text
        bodySmall: AppTextStyles.paragraphSmall, // Small paragraph text
        labelLarge: AppTextStyles.paragraphXSmall, // Extra small paragraph text
        labelMedium: AppTextStyles.overline, // Overline text
        labelSmall: AppTextStyles.button, // Button text
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.blue600,
          backgroundColor: AppColors.white,
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 4.0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blue600,
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue600,
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: AppColors.blue600),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      // Define other UI element themes here
    );
  }
}
