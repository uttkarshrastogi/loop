import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/icons/app_icon.dart';

class CustomCalendarPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onClose;

  const CustomCalendarPicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.onClose,
  });

  @override
  State<CustomCalendarPicker> createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late DateTime _displayedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _goToPreviousMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  Future<void> _selectYear(BuildContext context) async {
    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            // color: AppColors.background,
            decoration: BoxDecoration(
               color: AppColors.background,
              borderRadius: BorderRadius.circular(16)
            ),
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Text("Select Year", style: AppTextStyles.headingH6),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: AppColors.brandPurple, // Your brand color
                      onPrimary: AppColors.blue50,
                      onSurface: AppColors.black,
                      surface: AppColors.background,
                    ),
                    canvasColor: AppColors.background,
                    textTheme: Theme.of(context).textTheme.copyWith(
                      bodyLarge: AppTextStyles.paragraphMedium.copyWith(color: AppColors.textTertiary), // your text style
                    ),
                  ),
                  child: YearPicker(
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate,
                    initialDate: _displayedMonth,
                    selectedDate: _displayedMonth,
                    onChanged: (date) {
                      Navigator.pop(context, date.year);
                    },
                  ),
                ),
              )

              ],
            ),
          ),
        );
      },
    );

    if (selectedYear != null) {
      setState(() {
        _displayedMonth = DateTime(selectedYear, _displayedMonth.month);
      });
    }
  }

  List<DateTime> _generateDaysForMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday;
    final leadingEmptyDays = (firstWeekday % 7);

    final days = <DateTime>[];
    for (int i = 0; i < leadingEmptyDays; i++) {
      days.add(DateTime(month.year, month.month, 1 - (leadingEmptyDays - i)));
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    return days;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysForMonth(_displayedMonth);
    final monthName = DateFormat.yMMM().format(_displayedMonth);
    const weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SELECT DATE",
                      style: AppTextStyles.overline.copyWith(color: AppColors.textSecondary),
                    ),
                    AppIcon(
                      onClick: widget.onClose,
                      icon: Icons.close,
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  DateFormat('d, MMMM y').format(_selectedDate),
                  style: AppTextStyles.headingH5.copyWith(color: AppColors.textPrimary),
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _selectYear(context),
                      child: Row(
                        children: [
                          Text(
                            monthName,
                            style: AppTextStyles.paragraphMedium.copyWith(color: AppColors.textPrimary),
                          ),
                          const Gap(8),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _goToPreviousMonth,
                          icon: const Icon(Icons.chevron_left_rounded, color: AppColors.textPrimary),
                        ),
                        IconButton(
                          onPressed: _goToNextMonth,
                          icon: const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Weekday header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdayLabels.map((label) => Expanded(
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            )).toList(),
          ),

          const Gap(8),

          // Calendar Grid
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 40,
              ),
              itemBuilder: (context, index) {
                final day = days[index];
                final isCurrentMonth = day.month == _displayedMonth.month;
                final isSelected = _isSameDay(day, _selectedDate);
                final isEnabled = day.isAfter(widget.firstDate.subtract(const Duration(days: 1))) &&
                    day.isBefore(widget.lastDate.add(const Duration(days: 1))) &&
                    isCurrentMonth;
                return GestureDetector(
                  onTap: isEnabled ? () {
                    setState(() {
                      _selectedDate = day;
                    });
                  } : null,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.brandPurple : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: AppTextStyles.paragraphMedium.copyWith(
                          color: isEnabled
                              ? (isSelected ? Colors.white : AppColors.textPrimary)
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppButton(
              onPressed: () {
                widget.onDateSelected(_selectedDate);
                widget.onClose();
              },
              text: "Apply",
              width: double.infinity,
              backGroundColor: AppColors.brandPurple,
            ),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
