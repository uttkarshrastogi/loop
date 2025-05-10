import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;
  final double elevation;
  final bool hasGlow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.border,
    this.elevation = 2.0,
    this.hasGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? const EdgeInsets.all(18),
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor ??AppColors.background,
        borderRadius: borderRadius,
        border: border,
        boxShadow: hasGlow
            ? [] // glow handled separately
            : [
          if (elevation > 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: elevation,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: child,
    );

    if (!hasGlow) {
      return onTap != null
          ? GestureDetector(onTap: onTap, child: cardContent)
          : cardContent;
    }

    return  GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: Stack(
          children: [
            // 🟣 BLURRED BORDER BACKGROUND
            Positioned.fill(
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            // 🟣 GLOW BORDER
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedGradientBorder(borderRadius: borderRadius),
              ),
            ),
            // CARD CONTENT
            Container(
              margin: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: cardContent,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class AnimatedGradientBorder extends StatefulWidget {
  final BorderRadiusGeometry borderRadius;

  const AnimatedGradientBorder({super.key, required this.borderRadius});

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _GradientBorderPainter(
              animationValue: _controller.value,
              borderRadius: widget.borderRadius,
            ),
          );
        },
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final double animationValue;
  final BorderRadiusGeometry borderRadius;

  _GradientBorderPainter({required this.animationValue, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.resolve(TextDirection.ltr).toRRect(rect);

    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 6.28,
        transform: GradientRotation(animationValue * 6.28),
        colors: AppColors.brandGlow,
        stops: const [0.0, 0.3, 0.6, 0.8, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 // less aggressive
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2); // Thickness of the animated border

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
