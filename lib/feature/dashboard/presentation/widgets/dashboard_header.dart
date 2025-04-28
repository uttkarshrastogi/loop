import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class DashboardHeader extends StatelessWidget {
  final String userName;
  final double growthPercent;
  final String bestResult;

  const DashboardHeader({
    super.key,
    required this.userName,
    required this.growthPercent,
    required this.bestResult,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant , // Use light pastel bg if in light mode
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello 👋 $userName',
            style: AppTextStyles.headingH2,
          ),
          const SizedBox(height: 4),
          Text(
            'Your overall score is above average',
            style: AppTextStyles.paragraphMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatPill(icon: Icons.trending_up, text: 'Growth: +${growthPercent.toStringAsFixed(0)}%'),
              const SizedBox(width: 8),
              _StatPill(icon: Icons.emoji_events_outlined, text: 'Best Result: $bestResult'),
            ],
          )
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(text, style: AppTextStyles.paragraphSmall),
        ],
      ),
    );
  }
}
