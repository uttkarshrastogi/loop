import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/text_styles.dart';

class DurationPickerRow extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  const DurationPickerRow({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onPickStart,
    required this.onPickEnd,
  });

  @override
  Widget build(BuildContext context) {
    final duration = endDate.difference(startDate).inDays;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Duration", style: AppTextStyles.paragraphMedium.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text("($duration DAYS)", style: AppTextStyles.paragraphMedium),
            ],
          ),
          const Divider(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onPickStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(DateFormat.yMMMd().format(startDate)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text("to"),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onPickEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(DateFormat.yMMMd().format(endDate)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
