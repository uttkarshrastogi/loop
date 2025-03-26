import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loader_event.dart';
part 'loader_state.dart';
part 'loader_bloc.freezed.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(const LoaderState()) {
    on<LoadingOpen>(
        (event, emit) => emit(state.copyWith(count: state.count + 1)));
    on<LoadingClose>((event, emit) {
      int newCount = state.count - 1;
      if(newCount < 0){
        newCount = 0;
      }
      return emit(state.copyWith(count: state.count - 1));
    });
  }
}
