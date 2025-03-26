import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/spacing.dart';

class AppCloseButton extends StatelessWidget {
  final void Function()? onTap;
  const AppCloseButton({super.key, this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing2),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyButton.withOpacity(0.2)),
          color:  AppColors.greyButton.withOpacity(0.2), // Updated color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(
          Icons.close_rounded,
          color: AppColors.white, // Updated color
        ),
      ),
    );
  }
}
class AppBackButton extends StatelessWidget {
  final void Function()? onTap;
  const AppBackButton({super.key, this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing2),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyButton.withOpacity(0.2)),
          color:  AppColors.greyButton.withOpacity(0.2), // Updated color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.white, // Updated color
        ),
      ),
    );
  }
}
