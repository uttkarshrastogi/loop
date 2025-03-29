import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../theme/colors.dart';

class TiltParallaxImage extends StatefulWidget {
  const TiltParallaxImage({super.key});

  @override
  State<TiltParallaxImage> createState() => _TiltParallaxImageState();
}

class _TiltParallaxImageState extends State<TiltParallaxImage> {
  double dx = 0;
  double dy = 0;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
          // The values are reversed because tilting left/right = x, forward/backward = y
          setState(() {
            dx = event.x * 2; // control intensity
            dy = event.y * 2;
          });
        });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            // BoxShadow(
            //   color: AppColors.green800,
            //   blurRadius: 60,
            //   offset: const Offset(0, 60),
            // ), BoxShadow(
            //   color: AppColors.yellow800,
            //   blurRadius: 60,
            //   offset: const Offset(60, 0),
            // ),BoxShadow(
            //   color: AppColors.wildStrawberry800,
            //   blurRadius: 60,
            //   offset: const Offset(-60, 0),
            // ),
            // // BoxShadow(
            // //   color: AppColors.red800,
            // //   blurRadius: 60,
            // //   offset: const Offset(0, -60),
            // // ),
            BoxShadow(
              color: AppColors.neutral1100,
              blurRadius: 60,
              offset: const Offset(0, -60),
            ),
          ],
        ),
        child: Image.asset(
          fit: BoxFit.fitWidth,
          "assets/LiconBG.png",
          width: MediaQuery.of(context).size.width / 1.4,
        ),
      ),
    );
  }
}
