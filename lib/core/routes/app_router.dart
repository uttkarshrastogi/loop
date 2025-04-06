// import 'package:go_router/go_router.dart';
// import '../../feature/Onboarding/presentation/pages/get_started_page.dart';
// import '../../feature/dashboard/presentation/pages/dashboard_page.dart';
// import '../../feature/journey/presentation/pages/calendar_integration_screen.dart';
// import '../../feature/journey/presentation/pages/daily_checkin_screen.dart';
// import '../../feature/journey/presentation/pages/goal_input_screen.dart';
// import '../../feature/journey/presentation/pages/routine_input_screen.dart';
// import '../../feature/journey/presentation/pages/generate_screen.dart';
// import '../config/naviagtion_service.dart';
// import 'app_state.dart';
// import 'index.dart';
// import 'navigator_observer.dart';
// // Import your screen widgets here

// class AppRouter {
//   final AppState appState;

//   AppRouter(this.appState);

//   GoRouter get router => GoRouter(
//     // observers: [LoggingNavigatorObserver()],
//     // navigatorKey: NavigationService.navigatorKey,
//     refreshListenable: appState, // Listens to auth changes
//     // initialLocation: GoalInputScreen.routeName,
//     // redirect: (context, state) {
//     //   final isLoggedIn = appState.isLoggedIn;
//     //   final hasResolvedAuth = appState.hasResolvedAuth;
//     //   // ⏳ Wait for Firebase to finish checking auth
//     //   if (!hasResolvedAuth) return null;

//     //   if (isLoggedIn && state.matchedLocation == GetStartedPage.routeName) {
//     //     return GoalInputScreen.routeName;
//     //   }

//     //   if (!isLoggedIn && state.matchedLocation == DashboardPage.routeName) {
//     //     return DashboardPage.routeName;
//     //   }

//     //   return null;
//     // },

//     routes: [
//       // GoRoute(
//       //   path: GoalInputScreen.routeName,
//       //   builder: (context, state) => const GoalInputScreen(),
//       // ),
//       GoRoute(
//         path: RoutineInputScreen.routeName,
//         builder: (context, state) => RoutineInputScreen(extra: state.extra as Map<String, dynamic>?),
//       ),
//       GoRoute(
//         path: CalendarIntegrationScreen.routeName,
//         builder: (context, state) => CalendarIntegrationScreen(extra: state.extra as Map<String, dynamic>?),
//       ),
//       GoRoute(
//         path: TodoJourneyScreen.routeName,
//         builder: (context, state) => TodoJourneyScreen(extra: state.extra as Map<String, dynamic>?),
//       ),
//       GoRoute(
//         path: DailyCheckInScreen.routeName,
//         builder: (context, state) => DailyCheckInScreen(arguments: state.extra as Map<String, dynamic>?),
//       ),
//       GoRoute(
//         path: GetStartedPage.routeName,
//         builder: (context, state) => const GetStartedPage(),
//       ),
//       GoRoute(
//         path: DashboardPage.routeName,
//         builder: (context, state) => const DashboardPage(),
//       ),GoRoute(
//         path: Index.routeName,
//         builder: (context, state) => const Index(),
//       ),
//     ],
//   );
// }

