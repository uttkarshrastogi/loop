import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loop/core/model/openai_model.dart';
import 'package:loop/core/services/openai_service.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';
import 'package:uuid/uuid.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
final _uuid = Uuid();
class AIPlannerService {
  final OpenAIService _openAIService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AIPlannerService({required OpenAIService openAIService})
    : _openAIService = openAIService;

  /// Generate a personalized learning plan based on user's goal and routine
  Future<List<AiGeneratedTaskModel>> generateLearningPlan({
    required CreateGoalModel goalModel,
    required UserRoutineModel routineModel,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Format the routine details for the AI prompt
      final routineDetails = routineModel.getFormattedRoutine();

      // Calculate the deadline in days from now
      final deadline =
          goalModel.endDate != null
              ? '${_calculateDaysFromNow(goalModel.endDate!)} days'
              : 'flexible timeline';

      // Call OpenAI to generate the learning plan
      final aiResponse = await _openAIService.generateLearningPlan(
        goal: goalModel.title ?? 'Learn new skills',
        deadline: deadline,
        routineDetails: routineDetails,
      );

      // Convert AI response to AiGeneratedTaskModel objects
      final tasks = _convertAiResponseToTasks(
        aiResponse,
        userId,
        goalModel.title ?? 'Unknown goal',
      );

      // Save tasks to Firestore
      await _saveTasks(tasks);

      return tasks;
    } catch (e) {
      rethrow;
      debugPrint('Error generating learning plan: $e');
      throw Exception('Failed to generate learning plan: $e');
    }
  }

  /// Calculate days from now to a given date string (format: yyyy-MM-dd)
  int _calculateDaysFromNow(String dateString) {
    try {
      final parts = dateString.split('-');
      if (parts.length != 3)
        return 30; // Default to 30 days if format is invalid

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final targetDate = DateTime(year, month, day);
      final today = DateTime.now();

      return targetDate.difference(today).inDays + 1;
    } catch (e) {
      return 30; // Default to 30 days if parsing fails
    }
  }

  /// Convert AI response to AiGeneratedTaskModel objects
  List<AiGeneratedTaskModel> _convertAiResponseToTasks(
      OpenaiModel aiResponse,
      String userId,
      String goalTitle,
      ) {
    const String tempGoalId = 'temp-goal-id';
    final tasks = <AiGeneratedTaskModel>[];
    final now = DateTime.now();

    final content = aiResponse.choices?.first.message?.content;
    if (content == null) {
      throw Exception('OpenAI response content is null.');
    }

    String jsonStr = content;
    if (content.contains('```json')) {
      jsonStr = content.split('```json')[1].split('```')[0].trim();
    } else if (content.contains('```')) {
      jsonStr = content.split('```')[1].split('```')[0].trim();
    }

    final List<dynamic> parsed = json.decode(jsonStr);


    int dayOffset = 0;

    for (var i = 0; i < parsed.length; i++) {
      final taskData = parsed[i] as Map<String, dynamic>;

      final assignedDate = DateTime.now().add(Duration(days: i));

      final task = AiGeneratedTaskModel(
        id: _uuid.v4(),
        goalId: 'temp-goal-id',
        userId: userId,
        title: taskData['title'] ?? 'Untitled task',
        description: taskData['description'] ?? '',
        estimatedHours: _parseHours(taskData['hours']),
        source: (taskData['source'] is List)
            ? taskData['source'].join(', ')
            : (taskData['source'] ?? ''),
        assignedDate: assignedDate,
      );


      tasks.add(task);
    }


    return tasks;
  }

  double _estimateHoursFromTimeSlot(String timeSlot) {
    try {
      final parts = timeSlot.split('-');
      final start = _parseTimeToDouble(parts[0].trim());
      final end = _parseTimeToDouble(parts[1].trim());
      return (end - start).abs();
    } catch (_) {
      return 1.0; // fallback
    }
  }

  double _parseTimeToDouble(String timeStr) {
    final time = TimeOfDay(
      hour: int.parse(timeStr.split(':')[0]) + (timeStr.contains('PM') && !timeStr.startsWith('12') ? 12 : 0),
      minute: int.parse(timeStr.split(':')[1].replaceAll(RegExp(r'[^\d]'), '')),
    );
    return time.hour + time.minute / 60.0;
  }



  /// Parse hours from various formats (string, number, etc.)
  double _parseHours(dynamic hoursData) {
    if (hoursData == null) return 1.0;

    if (hoursData is num) {
      return hoursData.toDouble();
    }

    if (hoursData is String) {
      try {
        // Remove any non-numeric characters except decimal point
        final cleanedString = hoursData.replaceAll(RegExp(r'[^0-9.]'), '');
        return double.parse(cleanedString);
      } catch (e) {
        return 1.0;
      }
    }

    return 1.0; // Default value
  }

  /// Save tasks to Firestore
  Future<void> _saveTasks(List<AiGeneratedTaskModel> tasks) async {
    final batch = _firestore.batch();

    for (final task in tasks) {
      final docRef = _firestore.collection('ai_generated_tasks').doc(task.id); // use task.id explicitly
      batch.set(docRef, task.toFirestore());
    }

    await batch.commit();
  }


  /// Update task status (complete/skip)
  Future<void> updateTaskStatus(
    String taskId,
    bool isCompleted,
    bool isSkipped,
  ) async {
    try {
      await _firestore.collection('ai_generated_tasks').doc(taskId).update({
        'isCompleted': isCompleted,
        'isSkipped': isSkipped,
        'completedAt': isCompleted ? FieldValue.serverTimestamp() : null,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error updating task status: $e');
      throw Exception('Failed to update task status: $e');
    }
  }

  /// Get tasks for a specific goal
  Future<List<AiGeneratedTaskModel>> getTasksForGoal(String goalId) async {
    try {
      final snapshot =
          await _firestore
              .collection('ai_generated_tasks')
              .where('goalId', isEqualTo: goalId)
              .orderBy('assignedDate')
              .get();

      return snapshot.docs
          .map((doc) => AiGeneratedTaskModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      debugPrint('Error fetching tasks for goal: $e');
      return [];
    }
  }

  /// Get tasks for today
  Future<List<AiGeneratedTaskModel>> getTodayTasks() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final snapshot =
          await _firestore
              .collection('ai_generated_tasks')
              .where('userId', isEqualTo: userId)
              .where('assignedDate', isGreaterThanOrEqualTo: startOfDay)
              .where('assignedDate', isLessThan: endOfDay)
              .get();

      return snapshot.docs
          .map((doc) => AiGeneratedTaskModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      debugPrint('Error fetching today tasks: $e');
      return [];
    }
  }

  /// Generate feedback and adjust plan based on user progress
  Future<Map<String, dynamic>> generateFeedback({
    required String goalId,
    required String progress,
    required String userFeedback,})
  async {
    try {
      // Get the goal details
      final goalDoc = await _firestore.collection('goals').doc(goalId).get();
      final goalTitle = goalDoc.data()?['title'] ?? 'your goal';

      // Get the AI feedback
      final feedback = await _openAIService.generateFeedback(
        goal: goalTitle,
        progress: progress,
        feedback: userFeedback,
      );

      return feedback;
    } catch (e) {
      debugPrint('Error generating feedback: $e');
      throw Exception('Failed to generate feedback: $e');
    }
  }
}
