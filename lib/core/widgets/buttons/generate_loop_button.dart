import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class GenerateLoopButton extends StatefulWidget {
  final VoidCallback? onTap;

  const GenerateLoopButton({super.key, this.onTap});

  @override
  State<GenerateLoopButton> createState() => _GenerateLoopButtonState();
}

class _GenerateLoopButtonState extends State<GenerateLoopButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) => setState(() => _isPressed = true);
  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onTap?.call();
  }

  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: _isPressed
            ? Matrix4.translationValues(1, 2, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black,width: 1.5),
          color: AppColors.brandColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: _isPressed ? Offset(0, 0) : Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Generate Loop',
              style:AppTextStyles.headingH5.copyWith(fontWeight: FontWeight.w700,color: AppColors.white)
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
