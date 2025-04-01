import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppNudeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final Color? cursorColor;

  const AppNudeTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.hintStyle = AppTextStyles.headingH5,
    this.textStyle = AppTextStyles.headingH5,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: textStyle.copyWith(color: AppColors.white),
      cursorColor: cursorColor ?? AppColors.brandFuchsiaPurple400, // Optional override
      decoration: InputDecoration(
        filled: false,
        hintText: hintText,
        hintStyle: hintStyle.copyWith(color: AppColors.textButton),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

