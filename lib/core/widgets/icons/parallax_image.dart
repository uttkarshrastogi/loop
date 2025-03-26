import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class ParallaxImage extends StatefulWidget {
  const ParallaxImage({super.key});

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  double offset = 0;

  @override
  void initState() {
    super.initState();
    // Simulate a little bounce or parallax effect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        offset = 10;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          offset = 0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, offset, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral1100.withOpacity(0.5),
              blurRadius: 60,
              spreadRadius: 0,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Image.asset(
          "assets/LiconBG.png",
          width: MediaQuery.of(context).size.width / 1.4,
        ),
      ),
    );
  }
}
