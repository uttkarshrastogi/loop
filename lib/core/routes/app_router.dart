import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/routes/redirect.dart';
import 'package:loop/feature/journey/presentation/pages/add_goal_dialog.dart';
import 'package:loop/feature/journey/presentation/pages/generate_preview_screen.dart';
import '../../feature/Onboarding/presentation/pages/get_started_page.dart';
import '../../feature/Onboarding/presentation/pages/onboarding_screen.dart';
import '../../feature/ai/data/models/ai_generated_task_model.dart';
import '../../feature/dashboard/presentation/pages/dashboard_page.dart';
import '../../feature/dashboard/presentation/widgets/task_detail_screen.dart';
import '../../feature/goal/data/models/create_goal_model.dart';
import '../../feature/journey/presentation/pages/calendar_integration_screen.dart';

import '../../feature/journey/presentation/pages/routine_input_screen.dart';
import '../../feature/journey/presentation/pages/generate_screen.dart';
import '../../feature/user/data/models/user_routine_model.dart';
import '../../temp.dart';
import 'app_state.dart';
import 'index.dart';

class AppRouter {
  static final AppState appState = AppState();
  static final GoRouter router = GoRouter(
    refreshListenable: appState,
    initialLocation: GetStartedPage.routeName,
    redirect: (context, state) async {
      return await handleRedirectLogic(state: state, appState: appState);
    },
    routes: [
      GoRoute(
        path: GetStartedPage.routeName,
        pageBuilder: (context, state) => buildVerticalSlidePage(
          child: const GetStartedPage(),
          key: state.pageKey,
        ),
      ),
      // GoRoute(
      //   path: GeneratePreviewScreen.routeName,
      //   pageBuilder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>?;
      //     return buildSlidePage(
      //     child: GeneratePreviewScreen(
      //       goalModel: extra?['createGoalModel'] as CreateGoalModel,
      //       routineModel: extra?['userRoutineModel'] as UserRoutineModel,
      //     ),
      //     key: state.pageKey,
      //   );}
      // ),
      GoRoute(
        path: TempScreen.routeName,
        pageBuilder: (context, state) => buildSlidePage(
          child: TempScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: DashboardPage.routeName,
        pageBuilder: (context, state) => buildSlidePage(
          child: const DashboardPage(),
          key: state.pageKey,
        ),
      ),   GoRoute(
        path: TaskDetailScreen.routeName,
        pageBuilder: (context, state) => buildSlidePage(
          child:  TaskDetailScreen(task: state.extra as AiGeneratedTaskModel,),
          key: state.pageKey,
        ),
      ),
      // GoRoute(
      //   path: AddGoalDialog.routeName,
      //   pageBuilder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>?;
      //     return buildSlidePage(
      //       child: AddGoalDialog(
      //         initialGoal: extra?['goalModel'] as CreateGoalModel?,
      //         initialRoutine: extra?['routineModel'] as UserRoutineModel?,
      //       ),
      //       key: state.pageKey,
      //     );
      //   },
      // ),

      // GoRoute(
      //   path: RoutineInputScreen.routeName,
      //   pageBuilder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>?;
      //     return buildSlidePage(
      //       key: state.pageKey,
      //       child: RoutineInputScreen(
      //         initialGoal: extra?['goalModel'] as CreateGoalModel?,
      //         initialRoutine: extra?['routineModel'] as UserRoutineModel?,
      //       ),
      //     );
      //   },
      // ),
      //
      // GoRoute(
      //   path: CalendarIntegrationScreen.routeName,
      //   pageBuilder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>?;
      //     return buildSlidePage(
      //       key: state.pageKey,
      //       child: CalendarIntegrationScreen(
      //         createGoalModel: extra?['createGoalModel'] as CreateGoalModel,
      //         userRoutineModel: extra?['userRoutineModel'] as UserRoutineModel,
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        path: OnboardingScreen.routeName,
        pageBuilder: (context, state) => buildSlidePage(
          key: state.pageKey,
          child: OnboardingScreen(),
        ),
      ),
      // GoRoute(
      //   path: DailyCheckInScreen.routeName,
      //   pageBuilder: (context, state) => buildSlidePage(
      //     key: state.pageKey,
      //     child: DailyCheckInScreen(arguments: state.extra as Map<String, dynamic>?),
      //   ),
      // ),
      GoRoute(
        path: GenerateScreen.routeName,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return buildSlidePage(
            key: state.pageKey,
            child: GenerateScreen(
              createGoalModel: extra?['createGoalModel'] as CreateGoalModel,
              userRoutineModel: extra?['userRoutineModel'] as UserRoutineModel,
            ),
          );
        },
      ),
      GoRoute(
        path: IndexPage.routeName,
        pageBuilder: (context, state) => buildSlidePage(
          key: state.pageKey,
          child: const IndexPage(),
        ),
      ),
    ],
  );
}

// Slide transition for route navigation
CustomTransitionPage<T> buildSlidePage<T>({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const secondaryBegin = Offset.zero;
      const secondaryEnd = Offset(-0.3, 0.0); // slide out left
      final primaryTween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
      final secondaryTween = Tween(begin: secondaryBegin, end: secondaryEnd).chain(CurveTween(curve: Curves.easeIn));
      return SlideTransition(
        position: animation.drive(primaryTween),
        child: SlideTransition(
          position: secondaryAnimation.drive(secondaryTween),
          child: child,
        ),
      );
    },
  );

}
CustomTransitionPage<T> buildVerticalSlidePage<T>({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Slide up from bottom
      const end = Offset.zero;
      const secondaryBegin = Offset.zero;
      const secondaryEnd = Offset(0.0, -0.3); // slide slightly upwards when exiting
      final primaryTween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
      final secondaryTween = Tween(begin: secondaryBegin, end: secondaryEnd).chain(CurveTween(curve: Curves.easeIn));

      return SlideTransition(
        position: animation.drive(primaryTween),
        child: SlideTransition(
          position: secondaryAnimation.drive(secondaryTween),
          child: child,
        ),
      );
    },
  );
}

