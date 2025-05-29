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
        color: backgroundColor ?? AppColors.widgetBackground,
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

    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary( // 🚀 optimization: prevents re-rendering full parent
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedGradientBorder(borderRadius: borderRadius),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(3),
              child: cardContent,
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
      duration: const Duration(seconds: 20), // ⏳ Slowed down animation to 20s
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
    return RepaintBoundary( // 🚀 isolates even inside
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: SweepGradient(
                startAngle: 0.0,
                endAngle: 6.28,
                transform: GradientRotation(_controller.value * 6.28),
                colors: AppColors.brandGlow,
                stops: const [
                  0.0,
                  0.3,
                  0.6,
                  0.8,
                  1.0,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
