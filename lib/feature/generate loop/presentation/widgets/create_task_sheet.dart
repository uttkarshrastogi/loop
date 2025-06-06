import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import '../../../../core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../../../../core/widgets/buttons/generate_loop_button.dart';
import '../../../../core/widgets/inputs/app_nude_textfield.dart';
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
  bool _hasExpanded = false;

  @override
  void initState() {
    super.initState();

    // Start listening when the controller attaches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        if (!_hasExpanded && _controller.size < 1.0) {
          _hasExpanded = true;
          _controller.animateTo(
            1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }
  String _priority = 'Low';
  String _difficulty = 'Intense';
  Set<String> _selectedDays = {'Monday', 'Sunday', 'Thursday', 'Friday'};
  DateTime _startDate = DateTime(2025, 6, 10);
  DateTime _endDate = DateTime(2026, 6, 9);


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      expand: false,
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
              children: [
                Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width / 6,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
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
                AppNudeTextField(
                  minLines: 6,
                  maxLines: 10,
                  hintText: "Try and be as descriptive as possible...",
                  title: 'Describe your Loop.',
                  textStyle: AppTextStyles.paragraphMedium,
                ),
                const Gap(20),
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

                /// Frequency
                CustomCheckboxGrid(
                  title: "Frequency",
                  options: [
                    "Everyday",
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday",
                  ],
                  selected: _selectedDays,
                  onToggle: (day) => setState(() {
                    if (_selectedDays.contains(day)) {
                      _selectedDays.remove(day);
                    } else {
                      _selectedDays.add(day);
                    }
                  }),
                ),

                const Gap(16),

                /// Duration Picker
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

                const GenerateLoopButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
