import 'package:go_router/go_router.dart';
import '../../feature/Onboarding/presentation/pages/get_started_page.dart';
import '../../feature/dashboard/presentation/pages/dashboard_page.dart';
import '../config/naviagtion_service.dart';
import 'app_state.dart';
import 'index.dart';
import 'navigator_observer.dart';
// Import your screen widgets here

class AppRouter {
  final AppState appState;

  AppRouter(this.appState);

  GoRouter get router => GoRouter(
    observers: [LoggingNavigatorObserver()],
    navigatorKey: NavigationService.navigatorKey,
    refreshListenable: appState, // Listens to auth changes
    initialLocation: GetStartedPage.routeName,
    redirect: (context, state) {
      final isLoggedIn = appState.isLoggedIn;
      final hasResolvedAuth = appState.hasResolvedAuth;

      // ⏳ Wait for Firebase to finish checking auth
      if (!hasResolvedAuth) return null;

      if (isLoggedIn && state.matchedLocation == GetStartedPage.routeName) {
        return Index.routeName;
      }

      if (!isLoggedIn && state.matchedLocation == DashboardPage.routeName) {
        return GetStartedPage.routeName;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: GetStartedPage.routeName,
        builder: (context, state) => const GetStartedPage(),
      ),
      GoRoute(
        path: DashboardPage.routeName,
        builder: (context, state) => const DashboardPage(),
      ),GoRoute(
        path: Index.routeName,
        builder: (context, state) => const Index(),
      ),
    ],
  );
}

