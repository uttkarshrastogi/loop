import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class UserRoutineModel {
  final String? id;
  final String userId;
  final String goalId;
  final String wakeUpTime;
  final String sleepTime;
  final Map<String, String> workHours; // {"start": "09:00", "end": "17:00"}
  final List<FixedActivity> fixedActivities;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserRoutineModel({
    this.id,
    required this.userId,
    String? goalId,
    required this.wakeUpTime,
    required this.sleepTime,
    required this.workHours,
    required this.fixedActivities,
    this.createdAt,
    this.updatedAt,
  }) : goalId = goalId ?? _uuid.v4();

  factory UserRoutineModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserRoutineModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      goalId: data['goalId'] ??'',
      wakeUpTime: data['wakeUpTime'] ?? '07:00',
      sleepTime: data['sleepTime'] ?? '23:00',
      workHours: Map<String, String>.from(
        data['workHours'] ?? {'start': '09:00', 'end': '17:00'},
      ),
      fixedActivities: (data['fixedActivities'] as List<dynamic>?)
              ?.map((activity) => FixedActivity.fromMap(activity))
              .toList() ??
          [],
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
      'userId': userId,
      'goalId': goalId.isNotEmpty ? goalId : _uuid.v4(),
      'wakeUpTime': wakeUpTime,
      'sleepTime': sleepTime,
      'workHours': workHours,
      'fixedActivities':
          fixedActivities.map((activity) => activity.toMap()).toList(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserRoutineModel copyWith({
    String? id,
    String? userId,
    String? goalId,
    String? wakeUpTime,
    String? sleepTime,
    Map<String, String>? workHours,
    List<FixedActivity>? fixedActivities,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserRoutineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goalId: goalId ?? this.goalId,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      sleepTime: sleepTime ?? this.sleepTime,
      workHours: workHours ?? this.workHours,
      fixedActivities: fixedActivities ?? this.fixedActivities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String getFormattedRoutine() {
    final buffer = StringBuffer();
    buffer.writeln('Wake up at $wakeUpTime');
    buffer.writeln('Work from ${workHours['start']} to ${workHours['end']}');

    if (fixedActivities.isNotEmpty) {
      buffer.writeln('Fixed activities:');
      for (final activity in fixedActivities) {
        buffer.writeln(
            '- ${activity.name} from ${activity.startTime} to ${activity.endTime} on ${activity.daysOfWeek.join(', ')}');
      }
    }

    buffer.writeln('Sleep at $sleepTime');

    return buffer.toString();
  }
}

class FixedActivity {
  final String name;
  final String startTime;
  final String endTime;
  final List<String> daysOfWeek;

  FixedActivity({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
  });

  factory FixedActivity.fromMap(Map<String, dynamic> map) {
    return FixedActivity(
      name: map['name'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      daysOfWeek: List<String>.from(map['daysOfWeek'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'daysOfWeek': daysOfWeek,
    };
  }
}
