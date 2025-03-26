part of 'loader_bloc.dart';

@freezed
class LoaderEvent with _$LoaderEvent {
  const factory LoaderEvent.loadingON() = LoadingOpen;
  const factory LoaderEvent.loadingOFF() = LoadingClose;
}