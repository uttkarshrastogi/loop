import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';

class GoalTaskCard extends StatelessWidget {
  final AiGeneratedTaskModel task;
  final VoidCallback onComplete;
  final VoidCallback onSkip;
  final VoidCallback onEdit;
  final VoidCallback onViewTip;
  final bool hasGradient; // 👈 Added this

  const GoalTaskCard({
    super.key,
    required this.task,
    required this.onComplete,
    required this.onSkip,
    required this.onEdit,
    required this.onViewTip,
    this.hasGradient = false, // 👈 Default false
  });

  @override
  Widget build(BuildContext context) {
    final bool isToday = task.assignedDate.day == DateTime.now().day &&
        task.assignedDate.month == DateTime.now().month &&
        task.assignedDate.year == DateTime.now().year;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: hasGradient ? null : AppColors.widgetBackground,
        gradient: hasGradient
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF121212),
            Color(0xFF17171C),
            Color(0xFF1F1B24),
          ],
        )
            : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: task.isCompleted ? AppColors.brandPurple : AppColors.textSecondary,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  task.title,
                  style: AppTextStyles.paragraphLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.brandPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "TODAY",
                    style: AppTextStyles.paragraphXSmall.copyWith(color: Colors.white),
                  ),
                )
            ],
          ),
          const Gap(8),
          Text(
            task.description,
            style: AppTextStyles.paragraphSmall.copyWith(color: AppColors.textSecondary),
          ),
          const Gap(12),
          Row(
            children: [
              Icon(Icons.schedule, color: AppColors.textSecondary, size: 16),
              const Gap(4),
              Text(
                "${task.estimatedHours.toStringAsFixed(1)} hr",
                style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary),
              ),
              const Gap(16),
              GestureDetector(
                onTap: onViewTip,
                child: Row(
                  children: [
                    Icon(Icons.edit_note, size: 18, color: AppColors.textSecondary),
                    const Gap(4),
                    Text(
                      "View Tip",
                      style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                "Add Note",
                style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: "Complete",
                  onPressed: onComplete,
                  backGroundColor: AppColors.brandPurple,
                ),
              ),
              const Gap(8),
              Expanded(
                child: AppButton(
                  text: "Skip",
                  onPressed: onSkip,
                  withBorder: true,
                  isGhost: true,
                ),
              ),
              const Gap(8),
              Expanded(
                child: AppButton(
                  text: "Edit",
                  onPressed: onEdit,
                  backGroundColor: AppColors.neutral600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
