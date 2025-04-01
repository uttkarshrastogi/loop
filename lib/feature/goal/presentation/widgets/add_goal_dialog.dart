import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/buttons/app_slider.dart';
import '../../../../core/widgets/inputs/app_nude_textfield.dart';
import '../bloc/goal_bloc.dart';
import '../bloc/goal_event.dart';
import '../bloc/goal_state.dart';

class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime? _dueDate;

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: const Color(0xFF1C1C1E),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white),
            ),
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepPurpleAccent,
              onPrimary: Colors.white,
              surface: Color(0xFF1C1C1E),
              onSurface: Colors.white70,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Due date";
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void _onCreatePressed() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a goal title")),
      );
      return;
    }

    final Map<String, dynamic> body = {
      "title": title,
      "description": desc,
      "startDate": DateTime.now().toIso8601String(),
      "endDate":_dueDate!.toIso8601String(),
    };
    context.read<GoalBloc>().add(GoalEvent.createGoal(CreateGoalModel.fromJson(body)));

    // Optionally close the dialog after dispatching
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoalBloc, GoalState>(
      listener: (context, state) {
        state.maybeWhen(
          goalCreated: (_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("🎯 Goal created!")));
          },
          error: (msg) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("❌ $msg")));
          },
          orElse: () {},
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNudeTextField(
            hintText: 'Loop Name',
            hintStyle: AppTextStyles.paragraphLarge,
            controller: _titleController,
          ),
          const Gap(20),
          AppNudeTextField(
            hintText: 'Description...',
            hintStyle: AppTextStyles.paragraphMedium,
            textStyle: AppTextStyles.paragraphMedium,
            controller: _descController,
          ),
          const Gap(20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDateChip(
                "Due date",
                _dueDate,
                () => _pickDate(isStart: true),
              ),
            ],
          ),
          const Gap(24),
          AppButton(
            text: "Create Goal",
            onPressed: _onCreatePressed,
            backGroundColor: AppColors.brandFuchsiaPurple400,
            height: 30,
          ),
          // InviteFriendSlider(),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label, DateTime? date, VoidCallback onTap) {
    final hasValue = date != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2C2C2E),
          border: hasValue ? Border.all(color: Colors.deepPurpleAccent) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.white38),
            const SizedBox(width: 6),
            Text(
              _formatDate(date),
              style: TextStyle(
                color: hasValue ? Colors.white : Colors.white38,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
