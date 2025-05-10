import 'package:flutter/material.dart';

enum SlideDirection { left, right, up, down }

class AppSlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final SlideDirection direction;
  final double offset;

  const AppSlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.direction = SlideDirection.left,
    this.offset = 30.0,
  }) : super(key: key);

  @override
  State<AppSlideAnimation> createState() => _AppSlideAnimationState();
}

class _AppSlideAnimationState extends State<AppSlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Offset beginOffset;

    switch (widget.direction) {
      case SlideDirection.left:
        beginOffset = Offset(-widget.offset / 100, 0);
        break;
      case SlideDirection.right:
        beginOffset = Offset(widget.offset / 100, 0);
        break;
      case SlideDirection.up:
        beginOffset = Offset(0, -widget.offset / 100);
        break;
      case SlideDirection.down:
        beginOffset = Offset(0, widget.offset / 100);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
