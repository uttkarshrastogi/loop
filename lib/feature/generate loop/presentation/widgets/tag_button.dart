import 'package:flutter/material.dart';

class TagButton extends StatelessWidget {
  final String label;
  final bool isDisabled;

  const TagButton({
    required this.label,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isDisabled ? null : () {
        // Future selection logic
      },
      icon: const Icon(Icons.circle, size: 12),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        textStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
