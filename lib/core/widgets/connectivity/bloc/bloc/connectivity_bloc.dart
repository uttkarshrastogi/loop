import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityBloc() : super(const ConnectivityState.initial()) {
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(const ConnectivityState.connected());
      } else {
        emit(const ConnectivityState.disconnected());
      }
    });

    _initConnectivityMonitoring();
  }

  void _initConnectivityMonitoring() {
    _connectivity.onConnectivityChanged.listen((result) {
      add(ConnectivityEvent.connectivityChanged(
          isConnected: result[0] != ConnectivityResult.none));
    });
  }
}
