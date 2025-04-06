import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/inputs/app_nude_textfield.dart';
import 'routine_input_screen.dart';
import '../../../goal/presentation/bloc/goal_bloc.dart';
import '../../../goal/presentation/bloc/goal_state.dart';

class AddGoalDialog extends StatefulWidget {
  static const String routeName = '/AddGoalDialog';
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime? _dueDate;

  Future<void> _pickDate() async {
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

  // final double progress = (currentStep / totalSteps).clamp(0.0, 1.0);
  // final bool isLastStep = currentStep == totalSteps;
  String _formatDate(DateTime? date) {
    if (date == null) return "Pick a deadline";
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void _onCreatePressed() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✨ Give your Loop a name first")),
      );
      return;
    }

    if (_dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("📅 Pick a deadline for your Loop")),
      );
      return;
    }
    // print(FirebaseAuth.instance.currentUser?.email);
    final goalModel = CreateGoalModel(
      title: _titleController.text,
      description: _descController.text,
      startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      endDate: _dueDate?.toIso8601String(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RoutineInputScreen(
              extra: {'goalModel': goalModel.toJson()},
            ), // Replace with your target widget
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoalBloc, GoalState>(
      listener: (context, state) {
        state.maybeWhen(
          goalCreated: (_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("🌀 New Loop created! Let’s get started."),
              ),
            );
          },
          error: (msg) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("❌ Oops! $msg")));
          },
          orElse: () {},
        );
      },
      child: PageTemplate(
        mascot: Image.asset(
          "assets/loop_mascot_hi.png",
          height: MediaQuery.of(context).size.height/8,
        ),
        showBottomGradient: true,
        showBackArrow: false,
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(100),
              Text("Start a new Loop", style: AppTextStyles.headingH4),
              // Before AppNudeTextField (title input)
              Text(
                "Pick a starting point or write your own 🧠",
                style: AppTextStyles.paragraphLarge,
              ),
              const Gap(24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTemplateChip("I want to learn Flutter 🚀"),
                  _buildTemplateChip("I want to learn English 🇬🇧"),
                  _buildTemplateChip("I want to get fit 💪"),
                  _buildTemplateChip("I want to be more confident 🌟"),
                  // _buildTemplateChip("I want to wake up early ⏰"),
                  // _buildTemplateChip("Custom goal ✍️"),
                ],
              ),
              const Gap(20),
          
              const Gap(16),
              AppNudeTextField(
                hintText: 'What do you want to achieve?',
                hintStyle: AppTextStyles.paragraphLarge,
                controller: _titleController,
              ),
              const Gap(12),
              AppNudeTextField(
                hintText: 'Describe your Loop (optional)',
                hintStyle: AppTextStyles.paragraphMedium,
                textStyle: AppTextStyles.paragraphMedium,
                controller: _descController,
              ),
              const Gap(20),
              Text(
                "Due Date",
                style: AppTextStyles.paragraphLarge,
              ),
              const Gap(10),
              _buildDateChip("Pick a deadline", _dueDate, _pickDate),
              const Gap(60),
              AppButton(
                text: "Next",
                onPressed: _onCreatePressed,
                backGroundColor: AppColors.brandFuchsiaPurple400,
                height: 30,
              ),
          
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateChip(String label, DateTime? date, VoidCallback onTap) {
    final hasValue = date != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2C2C2E),
          border:
              hasValue
                  ? Border.all(color: AppColors.brandFuchsiaPurple400)
                  : null,
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

  Widget _buildTemplateChip(String text) {
    final isSelected = _titleController.text == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _titleController.text = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border:
              isSelected
                  ? Border.all(
                    color: AppColors.brandFuchsiaPurple400,
                    width: 1.5,
                  )
                  : null,
        ),
        child: Text(
          text,
          style: AppTextStyles.paragraphMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
