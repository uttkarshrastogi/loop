import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/generate_loop_button.dart';
import 'package:loop/core/widgets/inputs/app_nude_textfield.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';
import '../../../journey/presentation/pages/generate_screen.dart';
import 'custom_card_radio_group_widget.dart';
import 'custom_checkbox_grid.dart';
import 'duration_picker_row.dart';

final titleController = TextEditingController();
final descController = TextEditingController();
final titleFocus = FocusNode();

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({super.key});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final DraggableScrollableController _controller = DraggableScrollableController();
  bool _showFullForm = false;

  String _priority = 'Low';
  String _difficulty = 'Intense';
  Set<String> _selectedDays = {'Monday', 'Sunday', 'Thursday', 'Friday'};
  DateTime _startDate = DateTime(2025, 6, 10);
  DateTime _endDate = DateTime(2026, 6, 9);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        final currentSize = _controller.size;
        if (!_showFullForm && currentSize > 0.7) {
          setState(() {
            _showFullForm = true;
          });
        }
      });
    });
  }

  Future<void> _onGeneratePressed() async {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✨ Give your Loop a name first")),
      );
      return;
    }

    if (_endDate.isBefore(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("📅 End date must be after start date")),
      );
      return;
    }


      try {
        // final userId = routineModel.userId;
        final user = FirebaseAuth.instance.currentUser;

        final goalModel = CreateGoalModel(
          title: title,
          description: descController.text.trim(),
          startDate: DateFormat('yyyy-MM-dd').format(_startDate),
          endDate: _endDate.toIso8601String(),
          priority: _priority,
          difficulty: _difficulty,
          frequency: _selectedDays.toList(),
        );
        final userRoutineModel = UserRoutineModel(
          userId:user!.uid ,
          id: user.uid,
          goalId: user.uid,
          title: title,
          priority: _priority,
          difficulty: _difficulty,
          frequency: _selectedDays.toList(),
        );
        // Save goal
        final docRef = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('goal')
            .add(goalModel.toJson());

        context.push(
          GenerateScreen.routeName,
          extra: {
            'createGoalModel': goalModel,
            'userRoutineModel': userRoutineModel,
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }

  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Drag handle
                Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width / 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                /// Title
                AppNudeTextField(
                  minLines: 1,
                  maxLines: 2,
                  hintText: "Try and be as descriptive as possible...",
                  title: 'What do you want to Learn',
                  textStyle: AppTextStyles.paragraphMedium,
                  focusNode: titleFocus,
                  controller: titleController,
                ),
                const Gap(20),

                /// Description
                AppNudeTextField(
                  minLines: 6,
                  maxLines: 10,
                  hintText: "Try and be as descriptive as possible...",
                  title: 'Describe your Loop.',
                  controller: descController,
                  textStyle: AppTextStyles.paragraphMedium,
                ),
                const Gap(24),

                /// Generate button when collapsed
                if (!_showFullForm)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GenerateLoopButton(
                      onTap:_onGeneratePressed,
                    ),
                  ),

                /// Swipe up text
                if (!_showFullForm)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Text(
                        "Swipe up to add details manually!",
                        style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ),

                /// Show full form only when expanded
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _showFullForm
                      ? Column(
                    key: const ValueKey('expandedFields'),
                    children: [
                      AnimatedSlide(
                        offset: Offset(0, _showFullForm ? 0 : 0.2),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        child: AnimatedOpacity(
                          opacity: _showFullForm ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 400),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomCardRadioGroup(
                                      title: "Priority",
                                      options: ["Low", "Medium", "High"],
                                      selectedOption: _priority,
                                      onChanged: (value) => setState(() => _priority = value!),
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: CustomCardRadioGroup(
                                      title: "Difficulty",
                                      options: ["Light", "Moderate", "Intense"],
                                      selectedOption: _difficulty,
                                      onChanged: (value) => setState(() => _difficulty = value!),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(16),
                              CustomCheckboxGrid(
                                title: "Frequency",
                                options: [
                                  "Everyday", "Monday", "Tuesday", "Wednesday",
                                  "Thursday", "Friday", "Saturday", "Sunday",
                                ],
                                selected: _selectedDays,
                                onToggle: (day) => setState(() {
                                  _selectedDays.contains(day)
                                      ? _selectedDays.remove(day)
                                      : _selectedDays.add(day);
                                }),
                              ),
                              const Gap(16),
                              DurationPickerRow(
                                startDate: _startDate,
                                endDate: _endDate,
                                onPickStart: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _startDate,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) setState(() => _startDate = picked);
                                },
                                onPickEnd: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _endDate,
                                    firstDate: _startDate,
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) setState(() => _endDate = picked);
                                },
                              ),
                              const Gap(24),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: GenerateLoopButton(
                                  onTap:_onGeneratePressed,
                                ),
                              ),
                              const Gap(24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
