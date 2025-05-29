import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class LabeledDivider extends StatelessWidget {
  final String text;
  final Color color;
  final double thickness;
  final TextStyle? textStyle;

  const LabeledDivider({
    Key? key,
    required this.text,
    this.color = const Color(0xFF2f313b),
    this.thickness = 1.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
            endIndent: 8,
          ),
        ),
        Text(
          text,
          style: textStyle ??
              AppTextStyles.paragraphSmall.copyWith(color: AppColors.textSecondary),
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
            indent: 8,
          ),
        ),
      ],
    );
  }
}
