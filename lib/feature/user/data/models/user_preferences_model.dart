import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferencesModel {
  final String? id;
  final String userId;
  final String timezone;
  final List<BlockedHours> blockedHours;
  final String focusType; // 'morning', 'evening', 'distributed'
  final bool enableNotifications;
  final int dailyGoalHours;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserPreferencesModel({
    this.id,
    required this.userId,
    required this.timezone,
    required this.blockedHours,
    required this.focusType,
    this.enableNotifications = true,
    this.dailyGoalHours = 2,
    this.createdAt,
    this.updatedAt,
  });

  factory UserPreferencesModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return UserPreferencesModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      timezone: data['timezone'] ?? 'UTC',
      blockedHours: (data['blockedHours'] as List<dynamic>?)
          ?.map((hours) => BlockedHours.fromMap(hours))
          .toList() ?? [],
      focusType: data['focusType'] ?? 'distributed',
      enableNotifications: data['enableNotifications'] ?? true,
      dailyGoalHours: data['dailyGoalHours'] ?? 2,
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
      'timezone': timezone,
      'blockedHours': blockedHours.map((hours) => hours.toMap()).toList(),
      'focusType': focusType,
      'enableNotifications': enableNotifications,
      'dailyGoalHours': dailyGoalHours,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserPreferencesModel copyWith({
    String? id,
    String? userId,
    String? timezone,
    List<BlockedHours>? blockedHours,
    String? focusType,
    bool? enableNotifications,
    int? dailyGoalHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreferencesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timezone: timezone ?? this.timezone,
      blockedHours: blockedHours ?? this.blockedHours,
      focusType: focusType ?? this.focusType,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      dailyGoalHours: dailyGoalHours ?? this.dailyGoalHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method to check if a specific time is blocked
  bool isTimeBlocked(String dayOfWeek, String time) {
    for (final blockedHour in blockedHours) {
      if (blockedHour.daysOfWeek.contains(dayOfWeek) &&
          _isTimeBetween(time, blockedHour.startTime, blockedHour.endTime)) {
        return true;
      }
    }
    return false;
  }

  // Helper method to check if a time is between start and end times
  bool _isTimeBetween(String time, String startTime, String endTime) {
    final timeMinutes = _convertTimeToMinutes(time);
    final startMinutes = _convertTimeToMinutes(startTime);
    final endMinutes = _convertTimeToMinutes(endTime);
    
    return timeMinutes >= startMinutes && timeMinutes <= endMinutes;
  }

  // Helper method to convert time string (HH:MM) to minutes
  int _convertTimeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

class BlockedHours {
  final String startTime;
  final String endTime;
  final List<String> daysOfWeek; // ["Monday", "Wednesday", "Friday"]

  BlockedHours({
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
  });

  factory BlockedHours.fromMap(Map<String, dynamic> map) {
    return BlockedHours(
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      daysOfWeek: List<String>.from(map['daysOfWeek'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'daysOfWeek': daysOfWeek,
    };
  }
}
