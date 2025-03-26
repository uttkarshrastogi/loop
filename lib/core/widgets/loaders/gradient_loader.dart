import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress; // A value between 0.0 and 1.0
  final double height;
  final BorderRadiusGeometry borderRadius;

  const GradientProgressBar({
    Key? key,
    required this.progress,
    this.height = 8.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          // Background bar
          Container(
            height: height,
            color: Colors.grey.shade300, // Background color
          ),
          // Progress bar with gradient
          FractionallySizedBox(
            widthFactor: progress, // Progress value (0.0 to 1.0)
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF004991), // First gradient color
                    Color(0xFF0068CF), // Second gradient color
                    Color(0xFFB93F14), // Third gradient color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
