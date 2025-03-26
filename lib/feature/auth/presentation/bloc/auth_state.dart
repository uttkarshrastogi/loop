part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success(UserCredential? userCredential) = AuthSuccess;
  const factory AuthState.error({required String message}) = AuthError;
}
