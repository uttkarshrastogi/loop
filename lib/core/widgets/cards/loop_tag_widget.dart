import 'package:flutter/material.dart';

import '../../model/loop_card_model.dart';
// Assuming TagData is defined as above

class LoopTagWidget extends StatelessWidget {
  final TagData tag;

  const LoopTagWidget({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Default colors - you can refine these based on your app's theme
    final defaultBackgroundColor = theme.colorScheme.onSurface.withOpacity(0.08);
    final defaultIconColor = theme.colorScheme.onSurface.withOpacity(0.6);
    final defaultTextColor = theme.colorScheme.onSurface.withOpacity(0.8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: tag.backgroundColor ?? defaultBackgroundColor,
        borderRadius: BorderRadius.circular(16.0), // Pill shape
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // So the tag only takes needed width
        children: [
          Icon(
            tag.iconData,
            size: 16.0,
            color: tag.iconColor ?? defaultIconColor,
          ),
          const SizedBox(width: 6.0),
          Text(
            tag.label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: tag.textColor ?? defaultTextColor,
            ),
          ),
        ],
      ),
    );
  }
}