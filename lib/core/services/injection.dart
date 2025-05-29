import 'package:get_it/get_it.dart';
import 'package:loop/core/services/openai_service.dart';
import 'package:loop/feature/auth/data/datasources/auth_service.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/feature/goal/data/datasources/goal_service.dart';
import 'package:loop/feature/goal/presentation/bloc/goal_bloc.dart';
import 'package:loop/feature/journey/data/datasources/ai_planner_service.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';

import '../widgets/connectivity/bloc/bloc/connectivity_bloc.dart';
import '../widgets/globalLoader/bloc/bloc/loader_bloc.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {

  //auth
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerSingleton<OpenAIService>(OpenAIService());
  sl.registerSingleton<AIPlannerService>(AIPlannerService( openAIService: sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authService: sl()));

  //goal
  // sl.registerSingleton<GoalService>(GoalService());
  // sl.registerLazySingleton<GoalBloc>(() => GoalBloc(sl()));


  //miscellaneous
  sl.registerLazySingleton<ConnectivityBloc>(() => ConnectivityBloc());
  sl.registerLazySingleton<LoaderBloc>(() => LoaderBloc());

  //ai
  sl.registerSingleton<JourneyBloc>(JourneyBloc(sl()));
}
