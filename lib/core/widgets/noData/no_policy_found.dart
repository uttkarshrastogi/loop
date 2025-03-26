import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GraphicDocumentGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: SizedBox(
          // Ensure the Stack has a defined height

          width: screenWidth,
          child: Stack(
            children: [
              // SVG with radius
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.asset(
                  'assets/images/no_data_found.svg',
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned text overlay
              const Positioned(
                left: 16,
                top: 230,
                // Moves the text to the bottom
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No policy found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Geist',
                        fontWeight: FontWeight.w500,
                        height: 1.2, // Adjusted for better readability
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Invite friends to get more referrals',
                      style: TextStyle(
                        color: Color(0xFFD5D6D8),
                        fontSize: 12,
                        fontFamily: 'Geist',
                        fontWeight: FontWeight.w400,
                        height: 1.5, // Adjusted for better readability
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
