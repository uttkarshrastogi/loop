import 'package:go_router/go_router.dart';
import '../config/naviagtion_service.dart';
import 'app_state.dart';
import 'navigator_observer.dart';
// Import your screen widgets here

class AppRouter {
  final AppState appState;
  AppRouter(this.appState);
  static final GoRouter router = GoRouter(
    observers: [LoggingNavigatorObserver()],
    navigatorKey: NavigationService.navigatorKey,
    // refreshListenable: appState, // Listen to changes in AppState
    // initialLocation: SplashScreen.routeName,
    routes: [],
  );
}
