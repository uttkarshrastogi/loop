import 'package:flutter/material.dart';

class SquircleMaterialContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final Widget? child;
  final double cornerRadius;

  const SquircleMaterialContainer({
    Key? key,
    this.width,
    this.height,
    this.color = Colors.white,
    this.child,
    required this.cornerRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
    );

    return Material(
      type: MaterialType.transparency,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: color,
            shape: shape,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07), // 7% opacity
                blurRadius: 20,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
