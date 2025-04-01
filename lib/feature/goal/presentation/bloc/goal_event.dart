import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';

part 'goal_event.freezed.dart';

@freezed
class GoalEvent with _$GoalEvent {
  const factory GoalEvent.createGoal(CreateGoalModel createGoalModel) = CreateGoal;
  const factory GoalEvent.getGoal() = GetGoal;
  const factory GoalEvent.updateGoal({
    required String goalId,
    required Map<String, dynamic> data,
  }) = UpdateGoal;
  const factory GoalEvent.deleteGoal({
    required String goalId,
  }) = DeleteGoal;
}
