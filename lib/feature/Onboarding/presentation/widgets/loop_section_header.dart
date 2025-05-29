import 'package:flutter/material.dart';
import 'package:loop/core/theme/text_styles.dart';

class LoopSectionHeader extends StatelessWidget {
  const LoopSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("🔥 7-day Streak", style: AppTextStyles.headingH5),
        const SizedBox(height: 4),
        Text("82% success rate", style: AppTextStyles.paragraphSmall.copyWith(color: Colors.grey)),
      ],
    );
  }
}
