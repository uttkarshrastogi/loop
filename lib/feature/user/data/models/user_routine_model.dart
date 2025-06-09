import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserRoutineModel {
  final String? id;
  final String userId;
  final String goalId;
  final String? title;
  final DateTime? dueDate;
  final String priority;
  final String difficulty;
  final List<String> frequency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserRoutineModel({
    this.id,
    required this.userId,
    String? goalId,
    this.title,
    this.dueDate,
    required this.priority,
    required this.difficulty,
    required this.frequency,
    this.createdAt,
    this.updatedAt,
  }) : goalId = goalId ?? _uuid.v4();

  factory UserRoutineModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserRoutineModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      goalId: data['goalId'] ?? '',
      title: data['title'],
      dueDate: data['dueDate'] != null ? (data['dueDate'] as Timestamp).toDate() : null,
      priority: data['priority'] ?? 'Low',
      difficulty: data['difficulty'] ?? 'Moderate',
      frequency: List<String>.from(data['frequency'] ?? []),
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : null,
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'goalId': goalId.isNotEmpty ? goalId : _uuid.v4(),
      if (title != null) 'title': title,
      if (dueDate != null) 'dueDate': Timestamp.fromDate(dueDate!),
      'priority': priority,
      'difficulty': difficulty,
      'frequency': frequency,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserRoutineModel copyWith({
    String? id,
    String? userId,
    String? goalId,
    String? title,
    DateTime? dueDate,
    String? priority,
    String? difficulty,
    List<String>? frequency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserRoutineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      difficulty: difficulty ?? this.difficulty,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String getFormattedRoutine() {
    final buffer = StringBuffer();
    buffer.writeln('Goal: ${title ?? "No Title"} (due ${dueDate != null ? DateFormat.yMMMd().format(dueDate!) : "N/A"})');
    buffer.writeln('Priority: $priority');
    buffer.writeln('Difficulty: $difficulty');
    buffer.writeln('Frequency: ${frequency.join(', ')}');
    return buffer.toString();
  }
}
