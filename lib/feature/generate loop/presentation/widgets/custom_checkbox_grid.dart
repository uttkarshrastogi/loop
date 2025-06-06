import 'package:flutter/material.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.paragraphMedium.copyWith(fontWeight: FontWeight.w600)),
          const Divider(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              final isSelected = selected.contains(opt);
              return FilterChip(
                label: Text(opt),
                selected: isSelected,
                onSelected: (_) => onToggle(opt),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
