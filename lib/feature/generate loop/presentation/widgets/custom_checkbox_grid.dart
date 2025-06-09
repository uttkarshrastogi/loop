import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import '../../../../core/widgets/cards/squircle_container.dart';

class CustomCheckboxGrid extends StatelessWidget {
  final String title;
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const CustomCheckboxGrid({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SquircleMaterialContainer(
      cornerRadius: 30,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.paragraphMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary
              ),
            ),
            const Divider(height: 24),
            Wrap(
              spacing: 32, // horizontal spacing between columns
              runSpacing: 12, // vertical spacing between rows
              children: options.map((opt) {
                final isSelected = selected.contains(opt);
                return SizedBox(
                  width: 120, // makes columns align in a grid
                  child: GestureDetector(
                    onTap: () => onToggle(opt),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          checkColor: AppColors.background,
                          value: isSelected,
                          onChanged: (_) => onToggle(opt),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: AppColors.textPrimary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          opt,
                          style: AppTextStyles.paragraphXSmall.copyWith(
                            color: AppColors.textSecondary,

                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
