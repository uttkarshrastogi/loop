import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loop/feature/goal/data/models/create_goal_response_model.dart';
import 'package:loop/feature/goal/data/models/get_goal_response_model.dart';

part 'goal_state.freezed.dart';

@freezed
class GoalState with _$GoalState {
  const factory GoalState.initial() = _Initial;
  const factory GoalState.loading() = _Loading;
  const factory GoalState.goalCreated(CreateGoalResponseModel goal) = _GoalCreated;
  const factory GoalState.goalListLoaded(List<GetGoalResponseModel> goals) = _GoalListLoaded;
  const factory GoalState.goalUpdated(CreateGoalResponseModel updatedGoal) = _GoalUpdated;
  const factory GoalState.goalDeleted() = _GoalDeleted;
  const factory GoalState.error(String message) = _Error;
}
