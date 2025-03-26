import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static void go(String route) {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.go(route);
    }
  }
}
