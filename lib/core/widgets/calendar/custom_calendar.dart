import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/icons/app_icon.dart';

class CustomCalendarPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onClose;

  const CustomCalendarPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.onClose,
  }) : super(key: key);

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
    // Start the calendar on the selected date's month.
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _goToPreviousMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  Future<void> _selectYear(BuildContext context) async {
    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners for aesthetics
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Select Year",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
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

    final firstWeekday = firstDayOfMonth.weekday; // Monday=1, Sunday=7 in Dart
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final days = _generateDaysForMonth(_displayedMonth);
    final monthName = DateFormat.yMMM().format(_displayedMonth);
    final weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SELECT DATE",
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral400,
                        letterSpacing: 1.5,
                      ),
                    ),
                    AppIcon(
                      onClick: widget.onClose,
                      icon: Icons.close,
                    ),
                  ],
                ),
                Text(
                  DateFormat('d, MMMM y').format(_selectedDate),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.w500,
                  ),
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
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.neutral900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(14),
                          const Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.black,
                          ),
                          onPressed: _displayedMonth.isAfter(
                            DateTime(widget.firstDate.year, widget.firstDate.month),
                          )
                              ? _goToPreviousMonth
                              : null,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.black,
                          ),
                          onPressed: _displayedMonth.isBefore(
                            DateTime(widget.lastDate.year, widget.lastDate.month),
                          )
                              ? _goToNextMonth
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekdayLabels.map((label) {
              return Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(color: AppColors.neutral400),
                  ),
                ),
              );
            }).toList(),
          ),
          const Gap(8),
          Flexible(
            fit: FlexFit.loose,
            child: GridView.builder(
              padding: EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 40,
              ),
              itemBuilder: (context, index) {
                final day = days[index];
                final isCurrentMonth = day.month == _displayedMonth.month;
                final isSelected = _isSameDay(day, _selectedDate);
                final isEnabled = day.isAfter(
                    widget.firstDate.subtract(const Duration(days: 1))) &&
                    day.isBefore(
                        widget.lastDate.add(const Duration(days: 1))) &&
                    isCurrentMonth;
                return GestureDetector(
                  onTap: isEnabled
                      ? () {
                    setState(() {
                      _selectedDate = day;
                    });
                  }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: isEnabled
                              ? (isSelected ? Colors.white : Colors.black)
                              : Colors.grey[300],
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppButton(
              width: null,
              onPressed: () {
                widget.onDateSelected(_selectedDate);
                widget.onClose();
              },
              paddingHorizontal: 40,
              text: "Apply",
            ),
          ),
        ],
      ),
    );
  }
}

