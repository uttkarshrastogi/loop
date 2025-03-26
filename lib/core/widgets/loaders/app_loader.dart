import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key, this.size = 96});
  final double size;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(); // infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            'assets/LloaderBG.png', // Place your rotating icon image here
            width: widget.size,
            height: widget.size,
          ),
        )
    );
  }
}
