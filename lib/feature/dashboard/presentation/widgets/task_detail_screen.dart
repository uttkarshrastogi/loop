import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/cards/app_card.dart';

import '../../../ai/data/models/ai_generated_task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/TaskDetailScreen';
  final AiGeneratedTaskModel task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.textPrimary),
        title: Text('Task Details', style: AppTextStyles.headingH5),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(task.title, style: AppTextStyles.headingH4),
            const Gap(12),

            // Expected Outcome
            if (task.expectedOutcome.isNotEmpty)
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What you will achieve', style: AppTextStyles.headingH6),
                    const Gap(8),
                    Text(task.expectedOutcome, style: AppTextStyles.paragraphMedium),
                  ],
                ),
              ),
            const Gap(16),

            // Description
            Text('Overview', style: AppTextStyles.headingH6),
            const Gap(8),
            Text(task.description, style: AppTextStyles.paragraphMedium),
            const Gap(24),

            // Substeps
            if (task.subSteps.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Steps to follow', style: AppTextStyles.headingH6),
                  const Gap(8),
                  ...task.subSteps.map((step) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 18, color: Colors.white)),
                        Expanded(child: Text(step, style: AppTextStyles.paragraphMedium)),
                      ],
                    ),
                  )),
                ],
              ),
            const Gap(24),

            // Difficulty + Hours
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoBox(title: 'Difficulty', value: task.difficulty),
                _infoBox(title: 'Est. Hours', value: '${task.estimatedHours.toStringAsFixed(1)}h'),
              ],
            ),
            const Gap(24),

            // Motivation Tip
            if (task.motivationTip.isNotEmpty)
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stay Motivated 💪', style: AppTextStyles.headingH6),
                    const Gap(8),
                    Text(task.motivationTip, style: AppTextStyles.paragraphMedium),
                  ],
                ),
              ),
            const Gap(24),

            // Source Links
            if (task.source.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Learn From', style: AppTextStyles.headingH6),
                  const Gap(8),
                  GestureDetector(
                    onTap: () {
                      // TODO: open source link
                    },
                    child: Text(
                      task.source,
                      style: AppTextStyles.paragraphSmall.copyWith(
                        color: AppColors.brandColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            const Gap(24),

            // Reward
            if (task.reward.isNotEmpty)
              AppCard(
                padding: const EdgeInsets.all(16),
                // color: AppColors.success.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reward 🎉', style: AppTextStyles.headingH6),
                    const Gap(8),
                    Text(task.reward, style: AppTextStyles.paragraphMedium),
                  ],
                ),
              ),
            const Gap(32),

            // Action Button
            AppButton(
              text: "Mark as Completed",
              backGroundColor: AppColors.brandColor,
              onPressed: () {
                // TODO: handle completion
              },
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Widget _infoBox({required String title, required String value}) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headingH5),
          const Gap(4),
          Text(title, style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
