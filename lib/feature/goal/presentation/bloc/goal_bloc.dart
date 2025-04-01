import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/goal_service.dart';
import 'goal_event.dart';
import 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalService _goalService;

  GoalBloc(this._goalService) : super(const GoalState.initial()) {
    on<CreateGoal>(_onCreateGoal);
    on<GetGoal>(_onGetGoal);
    on<UpdateGoal>(_onUpdateGoal);
    on<DeleteGoal>(_onDeleteGoal);
  }

  Future<void> _onCreateGoal(CreateGoal event, Emitter<GoalState> emit) async {
    emit(const GoalState.loading());
    try {
      final result = await _goalService.createGoal(event.createGoalModel);
      emit(GoalState.goalCreated(result));
    } catch (e) {
      rethrow;
      emit(GoalState.error(e.toString()));
    }
  }

  Future<void> _onGetGoal(GetGoal event, Emitter<GoalState> emit) async {
    emit(const GoalState.loading());
    try {
      final goals = await _goalService.getGoal();
      emit(GoalState.goalListLoaded(goals));
    } catch (e) {
      emit(GoalState.error(e.toString()));
    }
  }

  Future<void> _onUpdateGoal(UpdateGoal event, Emitter<GoalState> emit) async {
    emit(const GoalState.loading());
    try {
      final updated = await _goalService.updateGoal(event.goalId, event.data);
      emit(GoalState.goalUpdated(updated));
    } catch (e) {
      emit(GoalState.error(e.toString()));
    }
  }

  Future<void> _onDeleteGoal(DeleteGoal event, Emitter<GoalState> emit) async {
    emit(const GoalState.loading());
    try {
      await _goalService.deleteGoal(event.goalId);
      emit(const GoalState.goalDeleted());
    } catch (e) {
      emit(GoalState.error(e.toString()));
    }
  }
}
