import 'package:flutter/material.dart';

class FadeSlideInText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final double offsetX; // how much to slide from left

  const FadeSlideInText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.offsetX = 30.0,
  }) : super(key: key);

  @override
  State<FadeSlideInText> createState() => _FadeSlideInTextState();
}

class _FadeSlideInTextState extends State<FadeSlideInText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-widget.offsetX / 100, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward(); // Start animation
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
        child: Text(
          widget.text,
          style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
