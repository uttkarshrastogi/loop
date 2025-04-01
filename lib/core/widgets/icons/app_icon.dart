import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.onClick,
    this.color,
    this.icon,
    this.size,
    this.iconColor,
    this.imageSvg,
  });

  final VoidCallback? onClick;
  final IconData? icon;
  final SvgPicture? imageSvg;
  final Color? iconColor;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border.withOpacity(0.1)),
          color: color ?? AppColors.surfaceVariant, // Updated color
          borderRadius: BorderRadius.circular(100.0),
        ),
        child:Padding(padding: EdgeInsets.all(2),child:  icon == null
            ? imageSvg
            : Icon(
          icon,
          size: size ?? 18,
          color: iconColor ?? AppColors.textSecondary, // Updated color
        ),)
       
      ),
    );
  }
}
