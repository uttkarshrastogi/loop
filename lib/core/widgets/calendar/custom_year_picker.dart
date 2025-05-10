import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart'; // your custom colors
import 'package:loop/core/theme/text_styles.dart'; // your text styles

class CustomYearPicker extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onYearSelected;

  const CustomYearPicker({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onYearSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final years = List<int>.generate(
      lastDate.year - firstDate.year + 1,
          (index) => firstDate.year + index,
    );

    return Container(
      color: AppColors.background, // Your background color here
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns like YearPicker
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == selectedDate.year;

          return GestureDetector(
            onTap: () => onYearSelected(DateTime(year)),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brandPurple.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: AppColors.brandPurple, width: 2)
                    : Border.all(color: Colors.transparent),
              ),
              alignment: Alignment.center,
              child: Text(
                '$year',
                style: isSelected
                    ? AppTextStyles.paragraphLarge.copyWith(
                  color: AppColors.brandPurple,
                  fontWeight: FontWeight.bold,
                )
                    : AppTextStyles.paragraphLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
