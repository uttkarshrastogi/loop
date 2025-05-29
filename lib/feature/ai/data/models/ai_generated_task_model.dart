import 'package:cloud_firestore/cloud_firestore.dart';

class AiGeneratedTaskModel {
  final String? id;
  final String goalId;
  final String userId;
  final String title;
  final String description;
  final double estimatedHours;
  final List<String> subSteps;
  final String difficulty; // "Easy" / "Medium" / "Hard"
  final String motivationTip;
  final String expectedOutcome;
  final String source;
  final String reward;
  final DateTime assignedDate;
  final bool isCompleted;
  final bool isSkipped;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AiGeneratedTaskModel({
    this.id,
    required this.goalId,
    required this.userId,
    required this.title,
    required this.description,
    required this.estimatedHours,
    this.subSteps = const [],
    this.difficulty = "Medium",
    this.motivationTip = "",
    this.expectedOutcome = "",
    required this.source,
    this.reward = "",
    required this.assignedDate,
    this.isCompleted = false,
    this.isSkipped = false,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AiGeneratedTaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AiGeneratedTaskModel(
      id: doc.id,
      goalId: data['goalId'] ?? '',
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      estimatedHours: (data['estimatedHours'] ?? 0).toDouble(),
      subSteps: List<String>.from(data['subSteps'] ?? []),
      difficulty: data['difficulty'] ?? 'Medium',
      motivationTip: data['motivationTip'] ?? '',
      expectedOutcome: data['expectedOutcome'] ?? '',
      source: data['source'] ?? '',
      reward: data['reward'] ?? '',
      assignedDate: data['assignedDate'] != null
          ? (data['assignedDate'] as Timestamp).toDate()
          : DateTime.now(),
      isCompleted: data['isCompleted'] ?? false,
      isSkipped: data['isSkipped'] ?? false,
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'goalId': goalId,
      'userId': userId,
      'title': title,
      'description': description,
      'estimatedHours': estimatedHours,
      'subSteps': subSteps,
      'difficulty': difficulty,
      'motivationTip': motivationTip,
      'expectedOutcome': expectedOutcome,
      'source': source,
      'reward': reward,
      'assignedDate': Timestamp.fromDate(assignedDate),
      'isCompleted': isCompleted,
      'isSkipped': isSkipped,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  AiGeneratedTaskModel copyWith({
    String? id,
    String? goalId,
    String? userId,
    String? title,
    String? description,
    double? estimatedHours,
    List<String>? subSteps,
    String? difficulty,
    String? motivationTip,
    String? expectedOutcome,
    String? source,
    String? reward,
    DateTime? assignedDate,
    bool? isCompleted,
    bool? isSkipped,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AiGeneratedTaskModel(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      subSteps: subSteps ?? this.subSteps,
      difficulty: difficulty ?? this.difficulty,
      motivationTip: motivationTip ?? this.motivationTip,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
      source: source ?? this.source,
      reward: reward ?? this.reward,
      assignedDate: assignedDate ?? this.assignedDate,
      isCompleted: isCompleted ?? this.isCompleted,
      isSkipped: isSkipped ?? this.isSkipped,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  AiGeneratedTaskModel markAsCompleted() {
    return copyWith(
      isCompleted: true,
      isSkipped: false,
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  AiGeneratedTaskModel markAsSkipped() {
    return copyWith(
      isCompleted: false,
      isSkipped: true,
      updatedAt: DateTime.now(),
    );
  }

  AiGeneratedTaskModel resetStatus() {
    return copyWith(
      isCompleted: false,
      isSkipped: false,
      completedAt: null,
      updatedAt: DateTime.now(),
    );
  }
}
