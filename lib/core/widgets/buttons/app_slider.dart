import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:permission_handler/permission_handler.dart'; // <-- new
import '../../../../core/widgets/buttons/appbutton.dart';
import 'dart:ui';

import '../../theme/colors.dart';
import '../../theme/text_styles.dart'; // For ImageFilter

class InviteFriendSlider extends StatelessWidget {
  const InviteFriendSlider({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white.withOpacity(0.3)),
              gradient: LinearGradient(
                colors: [
                  Colors.grey.withOpacity(0.3),
                  Colors.grey.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SlideAction(
              sliderButtonIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                width: 64,
                height: 64,
                child: const Icon(Icons.person_add_alt,
                    color: Colors.black, size: 24),
              ),
              sliderButtonIconPadding: 0,
              elevation: 0,
              outerColor: Colors.transparent,
              innerColor: Colors.white.withOpacity(0),
              sliderRotate: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Keep space for the sliderButtonIcon so text is centered
                  Container(width: 64, height: 64),
                  Text(
                    'Invite friends',
                    style: AppTextStyles.paragraphMedium
                        .copyWith(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.chevron_right,
                          color: Colors.white.withOpacity(0.4)),
                      Icon(Icons.chevron_right,
                          color: Colors.white.withOpacity(0.8)),
                      const Icon(Icons.chevron_right, color: Colors.white),
                      const Gap(24),
                    ],
                  ),
                ],
              ),
              onSubmit: () {

              },
            ),
          ),
        ),
      ),
    );
  }
}
