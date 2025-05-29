import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/buttons/appbutton.dart';
import '../../../../core/widgets/cards/app_card.dart';
import '../../../../core/widgets/inputs/app_textfield.dart';
import '../../../goal/data/models/create_goal_model.dart';

class GoalEditCard extends StatefulWidget {
  final CreateGoalModel initialGoal;

  const GoalEditCard({super.key, required this.initialGoal});

  @override
  State<GoalEditCard> createState() => _GoalEditCardState();
}

class _GoalEditCardState extends State<GoalEditCard> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialGoal.title ?? '');
    _descController = TextEditingController(text: widget.initialGoal.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit Your Goal", style: AppTextStyles.headingH4),
          const Gap(16),
          AppTextField(
            labelText: 'What do you want to achieve?',
            controller: _titleController,
            fieldTheme: FieldTheme.dark,
          ),
          const Gap(16),
          AppTextField(
            labelText: 'Describe your Loop (optional)',
            controller: _descController,
            fieldTheme: FieldTheme.dark,
          ),
          const Gap(24),
          AppButton(
            text: "Save",
            backGroundColor: AppColors.brandPurple,
            onPressed: () {
              final updatedGoal = widget.initialGoal.copyWith(
                title: _titleController.text.trim(),
                description: _descController.text.trim(),
              );
              Navigator.of(context).pop(updatedGoal);
            },
          ),
        ],
      ),
    );
  }
}
