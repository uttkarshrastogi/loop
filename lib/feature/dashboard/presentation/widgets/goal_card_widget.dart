import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class GoalCardWidget extends StatelessWidget {
  final String title;
  final int taskCount;
  final double progress; // 0.0 to 1.0
  final VoidCallback onTap;

  const GoalCardWidget({
    Key? key,
    required this.title,
    required this.taskCount,
    required this.progress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.widgetBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(-2, -2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(4, 6),
            ),
          ],

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$taskCount Tasks",
              style: AppTextStyles.paragraphXSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyles.headingH3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                   color: Colors.white,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary.withOpacity(0.15), // subtle track color
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress, // 0.0 to 1.0
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: AppColors.brandGlow,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${(progress * 100).round()}%",
                style: AppTextStyles.paragraphXSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
