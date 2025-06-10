import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppButton extends StatefulWidget {
  final String text;
  final double? width;
  final VoidCallback? onPressed;
  final bool isGhost;
  final bool withBorder;
  final bool isDisabled;
  final double height;
  final Color? textColor;
  final Color? backGroundColor;
  final double paddingHorizontal;
  final double fontSize;
  final double? radius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.isGhost = false,
    this.withBorder = true,
    this.isDisabled = false,
    this.height = 48.0,
    this.textColor,
    this.paddingHorizontal = 24,
    this.fontSize = 18,
    this.radius = 12,
    this.backGroundColor,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) => setState(() => _isPressed = true);
  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    if (!widget.isDisabled) widget.onPressed?.call();
  }

  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final isGhost = widget.isGhost;
    final bgColor = widget.isDisabled
        ? AppColors.neutral200
        : isGhost
        ? Colors.white // 👈 white background for ghost
        : widget.backGroundColor ?? AppColors.brandColor;

    final borderColor = widget.withBorder || isGhost
        ? (widget.isDisabled ? AppColors.neutral400 : AppColors.black)
        : Colors.transparent;

    final textColor = isGhost
        ? AppColors.black
        : widget.textColor ?? Colors.white;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: _isPressed
            ? Matrix4.translationValues(1, 2, 0)
            : Matrix4.identity(),
        width: widget.width,
        padding: EdgeInsets.symmetric(
          horizontal: widget.paddingHorizontal,
          vertical: (widget.height - 20) / 2,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 16),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: _isPressed ? Offset(0, 0) : Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: AppTextStyles.headingH5.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
