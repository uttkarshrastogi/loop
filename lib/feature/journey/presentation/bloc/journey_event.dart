import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';

part 'journey_event.freezed.dart';

@freezed
abstract class JourneyEvent with _$JourneyEvent {
  const factory JourneyEvent.loadTasks({required String goalId}) = LoadTasks;
  const factory JourneyEvent.loadTodayTasks() = LoadTodayTasks;
  // const factory JourneyEvent.generatePlan({required String goalId}) = GeneratePlan;
   const factory JourneyEvent.generatePlan({required CreateGoalModel goalmodel,required UserRoutineModel userRoutineModel }) = GeneratePlan;
  const factory JourneyEvent.updateTaskStatus({
    required String taskId,
    required bool isCompleted,
    required bool isSkipped,
  }) = UpdateTaskStatus;
}
