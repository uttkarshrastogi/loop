import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

import '../cards/squircle_container.dart';

class AppNudeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String title;
  final String? hintText;
  final String? subtitle;
  final int? minLines;
  final int? maxLines;
  final IconData? leadingIcon;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? cursorColor;
  final TextStyle? textStyle;

  const AppNudeTextField({
    super.key,
    this.controller,
    this.focusNode,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.titleStyle,
    this.subtitleStyle,
    this.cursorColor,
    this.textStyle, this.hintText,  this.minLines, this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SquircleMaterialContainer(
      // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      // margin: const EdgeInsets.symmetric(vertical: 8),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.03),
      //       blurRadius: 4,
      //       offset: const Offset(0, 2),
      //     )
      //   ],
      // ),
      cornerRadius: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Padding(
            padding: const EdgeInsets.fromLTRB(12,18,12,0),
            child: Row(
              children: [
                if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      leadingIcon,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                Text(
                  title,
                  style: titleStyle ??
                      AppTextStyles.paragraphMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          Divider(
            color: AppColors.textPrimary.withOpacity(0.1), // or a light grey like Colors.grey[300]
            thickness: 1,
            height: 16,
          ),

          // TextField
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextField(
              maxLines: maxLines,
              minLines: minLines,
              controller: controller,
              focusNode: focusNode,
              style: textStyle ??
                  AppTextStyles.headingH5.copyWith(
                    color: AppColors.textPrimary,
                  ),
              cursorColor: cursorColor ?? AppColors.brandColor,
              decoration:  InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          // Optional subtitle
        ],
      ),
    );
  }
}
