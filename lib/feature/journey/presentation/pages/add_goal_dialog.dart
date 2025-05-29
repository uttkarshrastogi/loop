import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/inputs/app_textfield.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_preview/pixel_preview/preview_widget.dart';
import 'package:pixel_preview/utils/presets.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/calendar/app_calendar_field.dart';
import '../../../../core/widgets/calendar/custom_calendar.dart';
import '../../../../core/widgets/cards/app_card.dart';
import '../../../../core/widgets/divider/labeled_divider.dart';
import '../../../../core/widgets/inputs/app_nude_textfield.dart';
import '../../../../core/widgets/loaders/app_loader.dart';
import '../../../../core/widgets/loaders/rive_loader.dart';
import '../../../user/data/models/user_routine_model.dart';
import 'generate_preview_screen.dart';
import 'routine_input_screen.dart';

class AddGoalDialog extends StatefulWidget {
  static const String routeName = '/AddGoalDialog';
  final CreateGoalModel? initialGoal;
  final UserRoutineModel? initialRoutine;
  const AddGoalDialog({super.key, this.initialGoal, this.initialRoutine});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  DateTime initial = DateTime.now();
void _showCalendar(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return CustomCalendarPicker(
        initialDate: initial,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        onDateSelected: (selectedDate) async {
          // bool isValid = await validateFamilyMemberAgeAndRelation(
          //     context,
          //     calculateAge(DateFormat('dd/MM/yyyy').format(selectedDate)),
          //     true);
          // setState(() {
          //   if (isValid) {
          //     initial = selectedDate;
          //     calendarController.text =
          //         DateFormat('dd/MM/yyyy').format(selectedDate);
          //   }
          // });
        },
        onClose: () {
          Navigator.of(ctx).pop();
        },
      );
    },
  );
}
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController calendarController = TextEditingController();

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

  void _onCreatePressed() async {
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
    final goalModel = (widget.initialGoal ?? CreateGoalModel()).copyWith(
      title: _titleController.text,
      description: _descController.text,
      startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      endDate: _dueDate?.toIso8601String(),
    );

    // Check for existing routine in Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final routineDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('routine')
              .doc('main')
              .get();
      if (routineDoc.exists || widget.initialRoutine != null) {
        final userRoutine =
            routineDoc.exists
                ? UserRoutineModel.fromFirestore(routineDoc)
                : widget.initialRoutine!;
        context.push(
          GeneratePreviewScreen.routeName,
          extra: {
            'createGoalModel': goalModel,
            'userRoutineModel': userRoutine,
          },
        );
        return;
      }
    }
    context.push(
      RoutineInputScreen.routeName,
      extra: {'goalModel': goalModel, 'userRoutineModel': null},
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialGoal?.title ?? '',
    );
    _descController = TextEditingController(
      text: widget.initialGoal?.description ?? '',
    );
    _dueDate =
        widget.initialGoal?.endDate != null
            ? DateTime.tryParse(widget.initialGoal!.endDate!)
            : null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      // mascot:   Image.asset(
      //   "assets/loop_mascot_hi.png",
      // ),
      showBottomGradient: true,
      showBackArrow: false,
      content: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              AppCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start a new Loop",
                          style: AppTextStyles.headingH4,
                        ),
                        const Gap(4),
                        Text(
                          "Pick a goal and turn it into a habit.",
                          style: AppTextStyles.paragraphSmall,
                        ),
                        const Gap(24),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTemplateChip("I want to learn Flutter"),
                            _buildTemplateChip("I want to learn English"),
                            _buildTemplateChip("I want to get fit"),
                            _buildTemplateChip("I want to be more confident"),
                          ],
                        ),
                      ],
                    ),

                    const Gap(12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LabeledDivider(text: "OR Create Your Own"),
                    ),
                    const Gap(20),
                    Text(
                      "Customize your Loop",
                      style: AppTextStyles.paragraphMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(16),
                    AppTextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(40)],
                      labelText: 'What do you want to achieve?',
                      controller: _titleController,
                      fieldTheme: FieldTheme.dark,
                    ),
                    const Gap(16),
                    AppTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(150),
                      ],
                      labelText: 'Describe your Loop (optional)',
                      controller: _descController,
                      fieldTheme: FieldTheme.dark,
                    ),
                    const Gap(16),
                    const Gap(20),
                    Text(
                      "Due Date",
                      style: AppTextStyles.paragraphMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(8),
                    // AppCalendarField(
                    //   isRequired: true,
                    //   labelText: 'Date of Birth',
                    //   controller: calendarController,
                    //   onTap: () {
                    //     // calendarController.text =
                    //     //     calculateBirthDate(memberData?.age ?? 0);
                    //
                    //   },
                    // ),
                    _buildDateChip("Pick a deadline", _dueDate, (){
                      _showCalendar(context);
                    }),
                    const Gap(32),
                    AppButton(
                      text: "Build My Loop",
                      onPressed: _onCreatePressed,
                      backGroundColor: AppColors.brandPurple,
                      height: 30,
                    ),
                  ],
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: hasValue ? AppColors.brandPurple : AppColors.widgetBackground,
          border: hasValue ? null : Border.all(color: AppColors.widgetBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeroIcon(
              HeroIcons.calendar,
              size: 16,
              color: hasValue ? Colors.white : AppColors.textPrimary,
            ),
            // Icon(
            //   Icons.calendar_today,
            //   size: 16,
            //   color: hasValue ? Colors.white : AppColors.textPrimary,
            // ),
            const SizedBox(width: 6),
            Text(
              _formatDate(date),
              style: AppTextStyles.paragraphSmall.copyWith(
                color: hasValue ? Colors.white : AppColors.textPrimary,
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
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                isSelected
                    ? null
                    : Border.all(color: AppColors.widgetBorder, width: 1.5),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: AppColors.brandPurple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                    : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: AppTextStyles.paragraphXSmall.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // if (isSelected) ...[
              //   const Icon(Icons.check, size: 16, color: Colors.white),
              //   const SizedBox(width: 6),
              // ],
            ],
          ),
        ),
      ),
    );

}}
