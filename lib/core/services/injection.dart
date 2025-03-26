import 'package:get_it/get_it.dart';
import 'package:loop/feature/auth/data/datasources/auth_service.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';

import '../widgets/connectivity/bloc/bloc/connectivity_bloc.dart';
import '../widgets/globalLoader/bloc/bloc/loader_bloc.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerLazySingleton<AuthBloc>(
        () => AuthBloc(authService: sl()),
  );sl.registerLazySingleton<ConnectivityBloc>(
        () => ConnectivityBloc(),
  );
  sl.registerLazySingleton<LoaderBloc>(
        () => LoaderBloc(),
  );
}
