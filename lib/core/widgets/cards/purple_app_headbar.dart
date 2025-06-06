import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/core/theme/colors.dart'; // Assuming AppColors.brandPurple exists
import 'package:loop/core/theme/text_styles.dart'; // Assuming AppTextStyles.headingH4 exists
import 'package:loop/core/theme/spacing.dart'; // Assuming AppSpacing exists

// Helper function to build your custom AppBar
PreferredSizeWidget buildPurpleHeaderAppBar(
    BuildContext context, {
      required String text,
      double height = 130.0, // Adjust height as needed from screenshot
    }) {
  final Color purpleColor = AppColors.brandColor; // Use your theme's purple

  return AppBar(
    toolbarHeight: height, // Set the desired height
    automaticallyImplyLeading: false, // No back arrow by default for this style
    backgroundColor: purpleColor,
    elevation: 2, // Flat design
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: purpleColor, // Make status bar background same as AppBar
      statusBarIconBrightness: Brightness.light, // For white icons on dark AppBar
    ),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(32), // Rounded bottom corners
      ),
    ),
    flexibleSpace: SafeArea( // Ensures content is below status bar within the AppBar
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing6,vertical: AppSpacing.spacing5),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: AppTextStyles.headingH4.copyWith( // Use a prominent text style
            color: Colors.white,
            // You might need to adjust fontSize, fontWeight for exact match
          ),
        ),
      ),
    ),
  );
}