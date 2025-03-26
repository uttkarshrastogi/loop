import 'package:freezed_annotation/freezed_annotation.dart';
part 'connectivity_event.freezed.dart';

@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.connectivityChanged({required bool isConnected}) = ConnectivityChanged;
}
