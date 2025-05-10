import 'package:flutter/material.dart';

class FadeInText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const FadeInText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  State<FadeInText> createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward(); // Start animation on appear
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
      child: Text(
        widget.text,
        style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
