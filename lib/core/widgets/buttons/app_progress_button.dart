import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppProgressButton extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final double height;
  final String? finalText; // Optional override when on last step

  const AppProgressButton({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onPressed,
    this.isDisabled = false,
    this.height = 48.0,
    this.finalText,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentStep / totalSteps).clamp(0.0, 1.0);
    final bool isLastStep = currentStep == totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: progress,
          minHeight: 4,
          backgroundColor: const Color(0xFF2C2C2E),
          valueColor: AlwaysStoppedAnimation(AppColors.brandColor),
        ),
        const SizedBox(height: 12),
        // Button
        SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandColor,
              disabledBackgroundColor: AppColors.neutral200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              elevation: 4,
            ),
            child: Text(
              isLastStep
                  ? (finalText ?? "Create Loop")
                  : "Next (Step $currentStep of $totalSteps)",
              style: AppTextStyles.paragraphSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
