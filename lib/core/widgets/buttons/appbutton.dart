import 'package:flutter/material.dart';
import 'package:loop/core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback? onPressed;
  final bool isGhost; // Controls if the button has a ghost style
  final bool withBorder; // Adds a border for "Ghost/With line"
  final bool isDisabled; // Controls if the button is disabled
  final double height; // Button height based on design (48px, 36px, 28px)
  final Color? textColor;
  final Color? backGroundColor;
  final double paddingHorizontal; // Custom text color
  final double fontSize;
  final double? radius; // Custom text color
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.isGhost = false,
    this.withBorder = false,
    this.isDisabled = false,
    this.height = 48.0,
    this.textColor,
    this.paddingHorizontal = 24,
    this.fontSize = 18,
    this.radius = 16, this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDisabled
        ? AppColors.neutral200
        : isGhost
            ? Colors.transparent
            : backGroundColor??AppColors.blue600;

    final borderColor = withBorder
        ? (isDisabled ? AppColors.neutral400 : AppColors.blue600)
        : Colors.transparent;


    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.neutral200,
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
              // Adjust padding based on button height
              horizontal: paddingHorizontal,
              vertical: width == null ? 8 : 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side: BorderSide(color: borderColor, width: 1.0),
          ),
          // shadowColor: AppColors.neutral200,
          elevation: isGhost ? 0 : 4.0,
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          text,
          style:AppTextStyles.paragraphSmall.copyWith(fontWeight: FontWeight.w500,color: Colors.white),
        ),
      ),
    );
  }
}
