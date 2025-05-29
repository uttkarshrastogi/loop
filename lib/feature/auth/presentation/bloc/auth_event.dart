part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.signUp() = _SignUp;
  const factory AuthEvent.signOut() = _SignOut;
}

