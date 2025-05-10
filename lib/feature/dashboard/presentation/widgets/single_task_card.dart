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
  final bool hasGradient;

  const GoalTaskCard({
    Key? key,
    required this.task,
    required this.onComplete,
    required this.onSkip,
    required this.onEdit,
    required this.onViewTip,
    this.hasGradient = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isToday = task.assignedDate.isAtSameMomentAs(
        DateTime(task.assignedDate.year, task.assignedDate.month, task.assignedDate.day));

    // Choose text colors dynamically
    final titleColor = hasGradient ? Colors.white : AppColors.textPrimary;
    final descColor = hasGradient ? Colors.white70 : AppColors.textSecondary;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {}, // optionally open detail
        child: Ink(
          decoration: hasGradient
              ? const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF121212),
                Color(0xFF17171C),
                Color(0xFF1F1B24),
              ],
            ),
          )
              : const BoxDecoration(color: AppColors.widgetBackground),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              Row(
                children: [
                  Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.isCompleted
                        ? AppColors.brandPurple
                        : AppColors.textSecondary,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      task.title,
                      style: AppTextStyles.paragraphLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                  ),
                  if (isToday)
                    Chip(
                      label: Text("TODAY",
                          style: AppTextStyles.paragraphXSmall
                              .copyWith(color: Colors.white)),
                      backgroundColor: AppColors.brandPurple,
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),

              const Gap(8),

              // Description
              Text(
                task.description,
                style: AppTextStyles.paragraphSmall.copyWith(
                  color: descColor,
                ),
              ),

              const Gap(12),

              // Metadata chips: difficulty, hours, reward
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    label: Text(task.difficulty),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    avatar: const Icon(Icons.schedule, size: 18),
                    label: Text("${task.estimatedHours.toStringAsFixed(1)}h"),
                  ),
                  if (task.reward.isNotEmpty)
                    Chip(label: Text(task.reward)),
                ],
              ),

              const Gap(12),

              // Action buttons
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
                      isGhost: true,
                      withBorder: true,
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

              const Gap(8),

              // View Tip as a text button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onViewTip,
                  icon: const Icon(Icons.lightbulb_outline, size: 18),
                  label: Text(
                    "View Tip",
                    style: AppTextStyles.paragraphXSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
