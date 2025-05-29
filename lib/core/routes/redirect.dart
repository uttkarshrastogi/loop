import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';
import 'package:loop/core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loop/core/routes/app_state.dart';
import 'package:go_router/go_router.dart';

import '../../feature/Onboarding/presentation/pages/get_started_page.dart';
import '../../feature/auth/data/datasources/auth_service.dart';
import '../../feature/journey/presentation/pages/add_goal_dialog.dart';

Future<String?> handleRedirectLogic({
  required GoRouterState state,
  required AppState appState,
}) async {
  final LoaderBloc lBloc = GetIt.instance<LoaderBloc>();
  final isLoggedIn = appState.isLoggedIn;
  final hasResolvedAuth = appState.hasResolvedAuth;

  // Wait for auth check to complete
  if (!hasResolvedAuth) return null;

  final currentLocation = state.matchedLocation;

  if (isLoggedIn) {
    // ✅ Check if user has goals
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final goals = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('goal')
        .get();
    // ✅ Logged in and on onboarding
    if ((currentLocation == GetStartedPage.routeName)&&(goals.docs.isEmpty)) {
      lBloc.add(const LoaderEvent.loadingOFF());
      return AddGoalDialog.routeName;
    }else if(currentLocation == GetStartedPage.routeName){
      lBloc.add(const LoaderEvent.loadingOFF());
      return DashboardPage.routeName;
    }

  } else {
    // ❌ Not logged in and on dashboard
    if (currentLocation == DashboardPage.routeName) {
      return GetStartedPage.routeName;
    }
  }

  return null;
}
