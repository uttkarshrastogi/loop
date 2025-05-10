import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/ai_planner_service.dart';
import 'journey_event.dart';
import 'journey_state.dart';

class JourneyBloc extends Bloc<JourneyEvent, JourneyState> {
  final AIPlannerService _aiPlannerService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  JourneyBloc(this._aiPlannerService) : super(const JourneyState.initial()) {
    on<LoadTasks>(_onLoadTasks);
    on<LoadTodayTasks>(_onLoadTodayTasks);
    on<GeneratePlan>(_onGeneratePlan);
    on<UpdateTaskStatus>(_onUpdateTaskStatus);
    on<LoadAllTasks>(_onLoadAllTasks);
  }
  Future<void> _onLoadTasks(LoadTasks event, Emitter<JourneyState> emit) async {
    emit(const JourneyState.loading());
    try {
      // event.loopDocId must be provided in the event
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      final tasks = await _aiPlannerService.getTasksForGoal(
        userId,
        event.loopDocId,
        event.goalId,
      );
      emit(JourneyState.tasksLoaded(tasks));
    } catch (e) {
      emit(JourneyState.error('Failed to load tasks: $e'));
    }
  }

  Future<void> _onLoadTodayTasks(
    LoadTodayTasks event,
    Emitter<JourneyState> emit,
  ) async {
    emit(const JourneyState.loading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      // event.loopDocId must be provided
      final tasks = await _aiPlannerService.getTodayTasks(
        userId,
        event.loopDocId,
      );
      emit(JourneyState.todayTasksLoaded(tasks));
    } catch (e) {
      emit(JourneyState.error('Failed to load today\'s tasks: $e'));
    }
  }

  Future<void> _onGeneratePlan(
    GeneratePlan event,
    Emitter<JourneyState> emit,
  ) async {
    emit(const JourneyState.loading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      // event.loopDocId must be provided
      final tasks = await _aiPlannerService.generateLearningPlan(
        goalModel: event.goalmodel,
        routineModel: event.userRoutineModel,
        userId: userId,
        loopDocId: event.loopDocId,
      );
      emit(JourneyState.tasksLoaded(tasks));
    } catch (e) {
      rethrow;
      emit(JourneyState.error('Failed to generate plan: $e'));
    }
  }
  Future<void> _onLoadAllTasks(
      LoadAllTasks event,
      Emitter<JourneyState> emit,
      ) async {
    emit(const JourneyState.loading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final groupedTasks = await _aiPlannerService.getAllTasksGroupedByGoal(userId);
      emit(JourneyState.allTasksLoaded(groupedTasks));
    } catch (e) {
      emit(JourneyState.error('Failed to load all tasks: $e'));
    }
  }


  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatus event,
    Emitter<JourneyState> emit,
  ) async {
    emit(const JourneyState.loading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      // event.loopDocId must be provided
      await _aiPlannerService.updateTaskStatus(
        userId,
        event.loopDocId,
        event.taskId,
        event.isCompleted,
        event.isSkipped,
      );
      emit(const JourneyState.taskStatusUpdated());
      // Reload the tasks to reflect the updated status
      final taskDoc =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('goal')
              .doc(event.loopDocId)
              .collection('ai_generated_tasks')
              .doc(event.taskId)
              .get();
      final goalId = taskDoc.data()?['goalId'] as String?;
      if (goalId != null) {
        add(LoadTasks(goalId: goalId, loopDocId: event.loopDocId));
      }
    } catch (e) {
      emit(JourneyState.error('Failed to update task status: $e'));
    }
  }
}
