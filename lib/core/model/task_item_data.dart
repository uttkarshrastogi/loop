import 'package:flutter/material.dart';

class TaskItemData {
  final String id;
  // final IconData iconData; // Using IconData for Flutter icons
  final String title;
  final String time;
  final String dateText;

  TaskItemData({
    required this.id,
    // required this.iconData,
    required this.title,
    required this.time,
    required this.dateText,
  });
}