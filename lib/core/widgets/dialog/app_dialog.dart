import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/icons/app_icon.dart';

import '../../theme/text_styles.dart';

void showAppDialog({
  required BuildContext context,
  required Widget child,
  required String title,
  Duration duration = const Duration(milliseconds: 300),
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "AppDialog",
    barrierDismissible: true,
    barrierColor: AppColors.barrierBackground,
    transitionDuration: duration,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      final opacityAnim = CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn, // fade in
        reverseCurve: Curves.easeOut, // fade out
      );

      final scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn, // scale up on show
          reverseCurve: Curves.linear, // no bounce on hide
        ),
      );

      return FadeTransition(
        opacity: opacityAnim,
        child: Transform.scale(
          scale: scaleAnim.value,
          child: _GlassDialogContent(title: title, child: child),
        ),
      );
    },
  );
}

class _GlassDialogContent extends StatelessWidget {
  final Widget child;
  final String title;

  const _GlassDialogContent({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.dialogBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.paragraphSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      AppIcon(onClick: () {
                        context.pop();
                      }, icon: Icons.close_rounded),
                    ],
                  ),
                  Gap(24),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
