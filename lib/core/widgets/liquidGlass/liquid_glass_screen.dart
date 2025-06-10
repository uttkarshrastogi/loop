import 'package:flutter/material.dart';

import 'LiquidGlassBox.dart';

class LiquidGlassScreen extends StatelessWidget {
  static const routeName = "/LiquidGlassScreen";
  const LiquidGlassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background (to refract/blur)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.blueAccent, Colors.black],
                center: Alignment(0.0, 0.3),
                radius: 1.0,
              ),
            ),
          ),
          // Glass container
          LiquidGlassBox(
            width: 300,
            height: 200,
            child: Center(
              child: Text(
                'Liquid Glass',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    )
    ;
  }
}
