import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id; // nullable for new task creation
  final String title;
  final String recurrence; // daily, weekly, monthly
  final dynamic interval; // e.g., 1 or ['Monday', 'Thursday']
  final DateTime? createdAt;
  final String userId;
  final List<String> completedDates;

  TaskModel({
    this.id,
    required this.title,
    required this.recurrence,
    required this.interval,
    this.createdAt,
    required this.userId,
    required this.completedDates,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      recurrence: data['recurrence'] ?? 'daily',
      interval: data['interval'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      userId: data['userId'] ?? '',
      completedDates: List<String>.from(data['completedDates'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'recurrence': recurrence,
      'interval': interval,
      'createdAt': FieldValue.serverTimestamp(),
      'userId': userId,
      'completedDates': completedDates,
    };
  }
}
