import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tasks';

  Future<void> createTask(TaskModel task) async {
    try {
      await _firestore.collection(_collection).add(task.toFirestore());
    } catch (e) {
      print('Create task failed: $e');
      rethrow;
    }
  }

  Future<TaskModel?> getTask(String taskId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(taskId).get();
      if (doc.exists) {
        return TaskModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Get task failed: $e');
      return null;
    }
  }

  Future<List<TaskModel>> getTasksByUser(String userId) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return query.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Fetch user tasks failed: $e');
      return [];
    }
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = FieldValue.serverTimestamp();
      await _firestore.collection(_collection).doc(taskId).update(updates);
    } catch (e) {
      print('Update task failed: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection(_collection).doc(taskId).delete();
    } catch (e) {
      print('Delete task failed: $e');
      rethrow;
    }
  }
}
