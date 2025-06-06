import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage; // 0.0 to 1.0
  final String label;
  final double radius;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const CircularPercentageIndicator({
    Key? key,
    required this.percentage,
    required this.label,
    this.radius = 24.0,
    this.strokeWidth = 4.0,
    this.progressColor = Colors.black87, // Color from screenshot
    this.backgroundColor = Colors.black12, // Light track color
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: progressColor,
    ) ?? TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: progressColor);

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: CircularProgressIndicator(
              value: 1.0, // Full circle for background
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
            ),
          ),
          // Progress arc
          SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi), // Flip to make it fill counter-clockwise for typical start
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(-math.pi / 2), // Start from top
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  // strokeCap: StrokeCap.round, // For rounded ends, if supported well
                ),
              ),
            ),
          ),
          Text(
            label,
            style: textStyle ?? defaultTextStyle,
          ),
        ],
      ),
    );
  }
}