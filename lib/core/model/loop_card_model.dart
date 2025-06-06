import 'package:flutter/material.dart';

// Data for an individual tag
class TagData {
  final IconData iconData;
  final String label;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;

  const TagData({
    required this.iconData,
    required this.label,
    this.iconColor, // Will default if null
    this.textColor,   // Will default if null
    this.backgroundColor, // Will default if null
  });
}

// Data for the entire card
class LoopCardData {
  final IconData titleIcon;
  final String title;
  final double progressPercent; // Value between 0.0 and 1.0
  final String progressLabel;   // e.g., "51"
  final List<TagData> tags;
  final String description;
  final List<IconData> bottomIconsLeft;
  final IconData? bottomIconRight;

  const LoopCardData({
    required this.titleIcon,
    required this.title,
    required this.progressPercent,
    required this.progressLabel,
    required this.tags,
    required this.description,
    required this.bottomIconsLeft,
    this.bottomIconRight,
  });
}