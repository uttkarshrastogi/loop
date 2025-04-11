import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:animations/animations.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/icons/app_icon.dart';
import 'package:loop/core/widgets/inputs/app_textfield.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';
import 'package:loop/feature/journey/presentation/pages/calendar_integration_screen.dart';

class RoutineInputScreen extends StatefulWidget {
  static const String routeName = '/routine-input';
  final Map<String, dynamic>? extra;

  const RoutineInputScreen({super.key, this.extra});

  @override
  State<RoutineInputScreen> createState() => _RoutineInputScreenState();
}

class _RoutineInputScreenState extends State<RoutineInputScreen> {
  bool _showWakeTimePicker = false;
  bool _showSleepTimePicker = false;
  bool _showStartWorkPicker = false;
  bool _showEndWorkPicker = false;
  String? asset;
  final List<String> mascotAssets = [
    'assets/loop_mascot_wake.png', // Step 0 - Wake/Sleep
    'assets/loop_mascot_time.png', // Step 1 - Work hours
    'assets/loop_mascot_activity.png', // Step 2 - Fixed activities
    'assets/loop_mascot_ready.png', // Step 3 - Final screen
  ];

  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _sleepTime = const TimeOfDay(hour: 23, minute: 0);

  TimeOfDay _workStartTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _workEndTime = const TimeOfDay(hour: 17, minute: 0);

  final _formKey = GlobalKey<FormState>();
  final _wakeUpController = TextEditingController(text: '07:00');
  final _sleepController = TextEditingController(text: '23:00');
  final _workStartController = TextEditingController(text: '09:00');
  final _workEndController = TextEditingController(text: '17:00');
  final List<FixedActivityInput> _fixedActivities = [];

  late CreateGoalModel _goalModel;
  int _currentStep = 0;
  bool _isLoading = false;
  void _updateMascotAsset() {
    setState(() {
      asset = mascotAssets[_currentStep];
    });
  }

  @override
  void initState() {
    super.initState();
    final extras = widget.extra;
    if (extras != null && extras.containsKey('goalModel')) {
      _goalModel = CreateGoalModel.fromJson(extras['goalModel']);
    }
    _updateMascotAsset(); // set initial mascot
  }

  @override
  void dispose() {
    _wakeUpController.dispose();
    _sleepController.dispose();
    _workStartController.dispose();
    _workEndController.dispose();
    super.dispose();
  }

  void _addFixedActivity() {
    setState(() {
      _fixedActivities.add(FixedActivityInput());
    });
  }

  void _removeFixedActivity(int index) {
    setState(() {
      _fixedActivities.removeAt(index);
    });
  }

  void _onNextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
        _updateMascotAsset();
      });
    } else {
      _saveRoutine();
    }
  }

  void _onPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _updateMascotAsset();
      });
    }
  }

  Future<void> _saveRoutine() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId == null) throw Exception('User not authenticated');

        final fixedActivities =
            _fixedActivities
                .map(
                  (a) => FixedActivity(
                    name: a.nameController.text,
                    startTime: a.startTimeController.text,
                    endTime: a.endTimeController.text,
                    daysOfWeek: a.selectedDays,
                  ),
                )
                .toList();
        String _formatTime(TimeOfDay time) {
          final now = DateTime.now();
          final dt = DateTime(
            now.year,
            now.month,
            now.day,
            time.hour,
            time.minute,
          );
          return TimeOfDay.fromDateTime(dt).format(context);
        }

        final routine = UserRoutineModel(
          userId: userId,
          wakeUpTime:
              '${_wakeTime.hour.toString().padLeft(2, '0')}:${_wakeTime.minute.toString().padLeft(2, '0')}',
          sleepTime:
              '${_sleepTime.hour.toString().padLeft(2, '0')}:${_sleepTime.minute.toString().padLeft(2, '0')}',
          workHours: {
            'start': _formatTime(_workStartTime),
            'end': _formatTime(_workEndTime),
          },

          fixedActivities: fixedActivities,
        );

        await FirebaseFirestore.instance
            .collection('user_routines')
            .add(routine.toFirestore());
        print("hi");
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => CalendarIntegrationScreen(
                    createGoalModel: _goalModel,
                    userRoutineModel: routine,
                  ),
            ),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      mascot: Image.asset(
        asset ?? "",
        height: MediaQuery.of(context).size.height / 6,
      ),
      showBottomGradient: true,
      title: 'Your Daily Routine',
      showBackArrow: false,
      content: SingleChildScrollView(child: Form(key: _formKey, child: _buildStepFlow())),
    );
  }

  Widget _buildStepFlow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(150),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 320),
              child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 500),
                reverse: false,
                transitionBuilder: (
                  Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType:
                        SharedAxisTransitionType.vertical, // Slide up/down
                    fillColor: Colors.transparent,
                    child: child,
                  );
                },
                child: SizedBox(
                  key: ValueKey(_currentStep),
                  width: double.infinity,
                  child: _buildStepCard(_currentStep),
                ),
              ),
            ),

            Gap(20),
            if (_currentStep != 0)
              Row(
                children: [
                  AppIcon(
                    iconColor: AppColors.surface,
                    size: 35,
                    onClick: _onPreviousStep,
                    icon: Icons.arrow_back_rounded,
                    color: AppColors.brandFuchsiaPurple400,
                  ),
                  // AppButton(text: "text", onPressed: onPressed)
                  // GestureDetector(
                  //   onTap: _onPreviousStep,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //
                  //       color: AppColors.brandFuchsiaPurple400
                  //     ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Icon(Icons.arrow_back),
                  //       )),
                  // ),
                  // Expanded(
                  //   child: AppButton(
                  //     text: 'Back',
                  //     onPressed: _onPreviousStep,
                  //     withBorder: true,
                  //     isGhost: true,
                  //   ),
                  // ),
                  const Gap(10),
                  Expanded(
                    child: AppButton(
                      backGroundColor: AppColors.brandFuchsiaPurple400,
                      text: 'Continue',
                      onPressed: _onNextStep,
                    ),
                  ),
                ],
              )
            else
              AppButton(
                backGroundColor: AppColors.brandFuchsiaPurple400,
                text: _currentStep < 3 ? 'Next' : 'Continue',
                onPressed: _onNextStep,
              ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index <= _currentStep;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        isActive
                            ? AppColors.brandFuchsiaPurple400
                            : AppColors.neutral300.withOpacity(0.3),
                  ),
                );
              }),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(int step) {
    switch (step) {
      case 0:
        return Column(
          key: const ValueKey(0),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCupertinoTimeSelector(
              title: 'What time do you wake up?',
              time: _wakeTime,
              showPicker: _showWakeTimePicker,
              onTap: () {
                setState(() {
                  _showWakeTimePicker = !_showWakeTimePicker;
                  _showSleepTimePicker = false;
                });
              },
              onTimeChanged: (time) {
                setState(() {
                  _wakeTime = time;
                  _wakeUpController.text =
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                });
              },
            ),
            const Gap(48),
            _buildCupertinoTimeSelector(
              title: 'What time do you go to sleep?',
              time: _sleepTime,
              showPicker: _showSleepTimePicker,
              onTap: () {
                setState(() {
                  _showSleepTimePicker = !_showSleepTimePicker;
                  _showWakeTimePicker = false;
                });
              },
              onTimeChanged: (time) {
                setState(() {
                  _sleepTime = time;
                  _sleepController.text =
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                });
              },
            ),
          ],
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What are your work/school hours?',
              style: AppTextStyles.headingH6,
            ),
            const Gap(32),
            _buildCupertinoTimeSelector(
              title: 'Start time',
              time: _workStartTime,
              showPicker: _showStartWorkPicker,
              onTap: () {
                setState(() {
                  _showStartWorkPicker = !_showStartWorkPicker;
                  _showEndWorkPicker = false;
                });
              },
              onTimeChanged: (time) {
                setState(() {
                  _workStartTime = time;
                });
              },
            ),
            const Gap(48),
            _buildCupertinoTimeSelector(
              title: 'End time',
              time: _workEndTime,
              showPicker: _showEndWorkPicker,
              onTap: () {
                setState(() {
                  _showEndWorkPicker = !_showEndWorkPicker;
                  _showStartWorkPicker = false;
                });
              },
              onTimeChanged: (time) {
                setState(() {
                  _workEndTime = time;
                });
              },
            ),
          ],
        );
      case 2:
        return Column(
          key: const ValueKey(2),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do you have any fixed activities?',
              style: AppTextStyles.headingH4,
            ),
            const Gap(8),
            Text(
              'E.g., gym, classes, family time',
              style: AppTextStyles.paragraphSmall.copyWith(
                color: AppColors.grey,
              ),
            ),
            const Gap(16),
            ..._fixedActivities
                .asMap()
                .entries
                .map(
                  (entry) => _buildFixedActivityInput(entry.value, entry.key),
                )
                .toList(),
            const Gap(16),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: AppButton(
                text: 'Add Activity',
                onPressed: _addFixedActivity,
                withBorder: true,
                isGhost: true,
              ),
            ),
            // OutlinedButton.icon(
            //   onPressed: _addFixedActivity,
            //   icon: const Icon(Icons.add),
            //   label: const Text('Add Activity'),
            // ),
          ],
        );
      case 3:
        return Column(
          key: const ValueKey(3),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ready to Continue?', style: AppTextStyles.headingH4),
            const Gap(12),
            Text(
              'You’ve set your daily routine. Let’s move on to calendar integration.',
              style: AppTextStyles.paragraphMedium,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCupertinoTimeSelector({
    required String title,
    required TimeOfDay time,
    required bool showPicker,
    required VoidCallback onTap,
    required void Function(TimeOfDay) onTimeChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headingH6),
        const Gap(32),
        // GestureDetector(
        //   onTap: onTap,
        //   child: Container(
        //     width: double.infinity,
        //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        //     decoration: BoxDecoration(
        //       color: AppColors.surfaceVariant,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Text(
        //       "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
        //       style: AppTextStyles.paragraphLarge,
        //     ),
        //   ),
        // ),
        // if (showPicker)
        SizedBox(
          height: 100,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: Brightness.light,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                  color: Colors.white, // <-- 👈 Set your desired time color
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(2000, 1, 1, time.hour, time.minute),
              onDateTimeChanged: (DateTime newDateTime) {
                onTimeChanged(
                  TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute),
                );
              },
              use24hFormat: false,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildCupertinoTimePicker(TextEditingController controller) {
    return GestureDetector(
      onTap: () async {
        final pickedTime = await showModalBottomSheet<TimeOfDay>(
          context: context,
          backgroundColor: Colors.black,
          builder: (_) {
            TimeOfDay tempTime = TimeOfDay.now();
            return Container(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: const Duration(hours: 9),
                      onTimerDurationChanged: (Duration newTime) {
                        tempTime = TimeOfDay(
                          hour: newTime.inHours,
                          minute: newTime.inMinutes % 60,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, tempTime);
                    },
                    child: const Text("Select"),
                  )
                ],
              ),
            );
          },
        );

        if (pickedTime != null) {
          controller.text = pickedTime.format(context);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          controller.text.isEmpty ? 'Select time' : controller.text,
          style: TextStyle(color: controller.text.isEmpty ? Colors.white38 : Colors.white),
        ),
      ),
    );
  }


  Widget _buildTimeField({
    required TextEditingController controller,
    String? labelText,
  }) {
    return AppTextField(
      controller: controller,
      labelText: labelText ?? "",
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final regex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
        if (!regex.hasMatch(value)) return 'Invalid (HH:MM)';
        return null;
      },
      onChanged: (_) async {
        final time = await showTimePicker(
          context: context,
          initialTime: _parseTimeOfDay(controller.text),
        );
        if (time != null) {
          controller.text =
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        }
      },
    );
  }

  Widget _buildFixedActivityInput(FixedActivityInput activity, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundZaxis,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity ${index + 1}', style: AppTextStyles.headingH5.copyWith(color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.surface),
                onPressed: () => _removeFixedActivity(index),
              ),
            ],
          ),

          const Gap(16),

          // Activity name input
          TextFormField(
            controller: activity.nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: 'Activity name',
              hintStyle: const TextStyle(color: Colors.white54),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
          ),

          const Gap(20),

          // Start Time
          Text('Start Time', style: AppTextStyles.paragraphMedium.copyWith(color: Colors.white)),
          const Gap(8),
          _buildInlineTimePicker(activity.startTimeController),

          const Gap(20),

          // End Time
          Text('End Time', style: AppTextStyles.paragraphMedium.copyWith(color: Colors.white)),
          const Gap(8),
          _buildInlineTimePicker(activity.endTimeController),

          const Gap(20),

          // Days
          Text('Days of week', style: AppTextStyles.paragraphMedium.copyWith(color: Colors.white)),
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
              final fullDay = _getFullDayName(day);
              final isSelected = activity.selectedDays.contains(fullDay);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected
                        ? activity.selectedDays.remove(fullDay)
                        : activity.selectedDays.add(fullDay);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.brandFuchsiaPurple400 : AppColors.green50,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //   color: isSelected ? AppColors.primary : AppColors.border,
                    // ),
                  ),
                  child: Text(
                    day,
                    style: AppTextStyles.paragraphSmall.copyWith(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineTimePicker(TextEditingController controller) {
    final now = TimeOfDay.now();
    final parts = controller.text.split(":");
    final hour = int.tryParse(parts.first) ?? now.hour;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : "0") ?? now.minute;
    final initialDateTime = DateTime(2000, 1, 1, hour, minute);

    return SizedBox(
      height: 100,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          initialDateTime: initialDateTime,
          use24hFormat: false,
          onDateTimeChanged: (DateTime newDateTime) {
            final formatted = TimeOfDay(
              hour: newDateTime.hour,
              minute: newDateTime.minute,
            ).format(context);

            setState(() {
              controller.text = formatted;
            });
          },
        ),
      ),
    );
  }



  TimeOfDay _parseTimeOfDay(String input) {
    try {
      final parts = input.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return const TimeOfDay(hour: 8, minute: 0);
    }
  }

  String _getFullDayName(String shortDay) {
    return {
      'Mon': 'Monday',
      'Tue': 'Tuesday',
      'Wed': 'Wednesday',
      'Thu': 'Thursday',
      'Fri': 'Friday',
      'Sat': 'Saturday',
      'Sun': 'Sunday',
    }[shortDay]!;
  }
}

class FixedActivityInput {
  final nameController = TextEditingController();
  final startTimeController = TextEditingController(text: '18:00');
  final endTimeController = TextEditingController(text: '19:00');
  final List<String> selectedDays = ['Monday', 'Wednesday', 'Friday'];

  void dispose() {
    nameController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
  }

}

