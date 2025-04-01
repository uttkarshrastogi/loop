import 'package:flutter/material.dart';
import 'package:loop/core/widgets/loaders/app_loader.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/feature/goal/presentation/bloc/goal_bloc.dart';
import 'package:toastification/toastification.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_state.dart';
import 'core/services/injection.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import 'core/widgets/connectivity/bloc/bloc/connectivity_bloc.dart';
import 'core/widgets/connectivity/bloc/bloc/connectivity_state.dart';
import 'core/widgets/connectivity/presentation/connectivity_screen.dart';
import 'core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';
import 'core/widgets/globalLoader/presentation/loader.dart';
final appState = AppState();
final appRouter = AppRouter(appState);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // final config = GetIt.instance<FlavorConfig>();

    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LoaderBloc>()),
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<ConnectivityBloc>()),
          BlocProvider(create: (context) => sl<GoalBloc>()),
          BlocProvider(create: (_) => UIInteractionCubit()),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            // MonthYearPickerLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerDelegate: appRouter.router.routerDelegate,
          routeInformationParser: appRouter.router.routeInformationParser,
          routeInformationProvider: appRouter.router.routeInformationProvider,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: Stack(
                children: [
                  child!,
                  BlocBuilder<LoaderBloc, LoaderState>(
                    builder: (context, state) {
                      final show = state.count > 0 || !appState.hasResolvedAuth;
                      return AnimatedOpacity(
                        opacity: show ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: IgnorePointer(
                          ignoring: !show,
                          child: const AppLoader(),
                        ),
                      );
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
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
