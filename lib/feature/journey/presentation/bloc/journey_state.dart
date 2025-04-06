import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../ai/data/models/ai_generated_task_model.dart';

part 'journey_state.freezed.dart';

@freezed
abstract class JourneyState with _$JourneyState {
  const factory JourneyState.initial() = JourneyInitial;
  const factory JourneyState.loading() = JourneyLoading;
  const factory JourneyState.tasksLoaded(List<AiGeneratedTaskModel> tasks) = JourneyTasksLoaded;
  const factory JourneyState.todayTasksLoaded(List<AiGeneratedTaskModel> tasks) = JourneyTodayTasksLoaded;
  const factory JourneyState.planGenerated() = JourneyPlanGenerated;
  const factory JourneyState.taskStatusUpdated() = JourneyTaskStatusUpdated;
  const factory JourneyState.error(String message) = JourneyError;
}
