import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loop/core/theme/colors.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/cards/squircle_container.dart';

class CustomCardRadioGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String?> onChanged;

  const CustomCardRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SquircleMaterialContainer(
      cornerRadius: 30,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0,18,12,12),
            child: Text(title, style: AppTextStyles.paragraphMedium.copyWith(fontWeight: FontWeight.w600)),
          ),
          Divider(
            color: AppColors.textSecondary.withOpacity(0.1),
            height: 0,
          ),
          ...options.map((option) {
            return RadioListTile<String>(

              title: Text(option),
              value: option,
              groupValue: selectedOption,
              onChanged: onChanged,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ],
      ),
    );
  }
}
