import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class LoopData {
  final String title;
  final bool isCompleted;
  final String recurrence;

  LoopData({
    required this.title,
    required this.isCompleted,
    required this.recurrence,
  });
}

class LoopTile extends StatelessWidget {
  final LoopData loop;

  const LoopTile({super.key, required this.loop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // mark complete or navigate
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: loop.isCompleted
              ? Colors.grey.shade200
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loop.title,
              style: loop.isCompleted
                  ? AppTextStyles.paragraphMedium.copyWith(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              )
                  : AppTextStyles.paragraphMedium,
            ),
            const SizedBox(height: 6),
            Text(
              "Repeat: ${loop.recurrence}",
              style: AppTextStyles.paragraphXSmall.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
