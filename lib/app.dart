import 'package:flutter/material.dart';
import 'package:loop/core/routes/app_router.dart';
import 'package:loop/core/widgets/loaders/app_loader.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:toastification/toastification.dart';
import 'core/services/injection.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/theme_cubit.dart';
import 'core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import 'core/widgets/connectivity/bloc/bloc/connectivity_bloc.dart';
import 'core/widgets/connectivity/bloc/bloc/connectivity_state.dart';
import 'core/widgets/connectivity/presentation/connectivity_screen.dart';
import 'core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LoaderBloc>()),
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<ConnectivityBloc>()),
          BlocProvider(create: (context) => sl<JourneyBloc>()),
          BlocProvider(create: (_) => UIInteractionCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return MaterialApp.router(
              // themeMode: mode,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              // darkTheme:AppTheme.dark() ,
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider: AppRouter.router
                  .routeInformationProvider,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: Stack(
                    children: [
                      child!,
                      BlocBuilder<LoaderBloc, LoaderState>(
                        builder: (context, state) {
                          if (state.count > 0) {
                            return const AppLoader();
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<ConnectivityBloc, ConnectivityState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const SizedBox.shrink(),
                            connected: () => const SizedBox.shrink(),
                            disconnected: () => const Connectivity(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
