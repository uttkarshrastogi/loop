import 'dart:developer';

import 'package:flutter/material.dart';

import '../services/analytics_service.dart';

class LoggingNavigatorObserver extends NavigatorObserver {
  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);
    // log('Navigated to: ${route.settings.name}');
    if (route.settings.name != null) {
      String eventName = '';
      if (route.settings.name == '/') {
        eventName = 'Home';
      } else {
        eventName = 'screen${route.settings.name?.replaceAll('/', '_')}';
      }
      await AnalyticsService.logEvent(AnalyticsEvent(eventName));
    }
  }

  // @override
  // void didPop(Route route, Route? previousRoute) {
  //   super.didPop(route, previousRoute);
  //   log('Popped from: ${route.settings.name}');
  // }

  // @override
  // void didRemove(Route route, Route? previousRoute) {
  //   super.didRemove(route, previousRoute);
  //   log('Removed: ${route.settings.name}');
  // }
}
