part of 'loader_bloc.dart';

@freezed
class LoaderState with _$LoaderState {
  const factory LoaderState({@Default(0) int count}) = _LoaderState;
}
