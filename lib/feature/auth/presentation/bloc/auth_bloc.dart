import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/auth_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(const AuthState.initial()) {
    on<_SignUp>((event, emit) async{
      emit(const AuthLoading());
      try {
        final response = await authService.signInWithGoogle();
        emit(AuthState.success(response));
      } catch (e) {
        emit(AuthState.error(message: e.toString()));
      }
    }); on<_SignOut>((event, emit) async{
      emit(const AuthLoading());
      try {
        await authService.signOut();
        emit(AuthState.success(null));
      } catch (e) {
        emit(AuthState.error(message: e.toString()));
      }
    });
  }
}
