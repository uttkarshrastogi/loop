import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';

class StarButton extends StatefulWidget {
  final VoidCallback? onTap;
  const StarButton({super.key, this.onTap});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onTap?.call(); // call the tap action after release
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        height: 65,
        width: 65,
        transform: _isPressed
            ? Matrix4.translationValues(1, 2, 0) // optional subtle sink
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.brandColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.black,width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: _isPressed ? Offset(0, 0) : Offset(3, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
