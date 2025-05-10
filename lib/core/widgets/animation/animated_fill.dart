import 'package:flutter/material.dart';

class AnimatedFill extends StatefulWidget {
  final bool isActive;
  final Color fillColor;
  final double radius;
  final double height;
  final double width;

  const AnimatedFill({
    Key? key,
    required this.isActive,
    required this.fillColor,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<AnimatedFill> createState() => _AnimatedFillState();
}

class _AnimatedFillState extends State<AnimatedFill> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedFill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Stack(
            children: [
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.transparent,
              ),
              Positioned.fill(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    color: widget.fillColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
