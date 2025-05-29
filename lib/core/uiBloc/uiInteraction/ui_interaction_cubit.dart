import 'package:flutter_bloc/flutter_bloc.dart';

enum UIState { normal, sheetOpen }

class UIInteractionCubit extends Cubit<UIState> {
  UIInteractionCubit() : super(UIState.normal);

  void openSheet() => emit(UIState.sheetOpen);

  void closeSheet() => emit(UIState.normal);
}
