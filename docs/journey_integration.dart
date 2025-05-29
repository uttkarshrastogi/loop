// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loop/core/services/openai_service.dart';
// import 'package:loop/feature/journey/data/datasources/ai_planner_service.dart';
// import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
// import 'package:loop/feature/journey/presentation/pages/calendar_integration_screen.dart';
// import 'package:loop/feature/journey/presentation/pages/daily_checkin_screen.dart';
// import 'package:loop/feature/journey/presentation/pages/goal_input_screen.dart';
// import 'package:loop/feature/journey/presentation/pages/routine_input_screen.dart';
// import 'package:loop/feature/journey/presentation/pages/generate_screen.dart';

// // Add journey routes to the app router
// final journeyRoutes = [
//   GoRoute(
//     path: GoalInputScreen.routeName,
//     builder: (context, state) => const GoalInputScreen(),
//   ),
//   GoRoute(
//     path: RoutineInputScreen.routeName,
//     builder: (context, state) => RoutineInputScreen(extra: state.extra as Map<String, dynamic>?),
//   ),
//   GoRoute(
//     path: CalendarIntegrationScreen.routeName,
//     builder: (context, state) => CalendarIntegrationScreen(extra: state.extra as Map<String, dynamic>?),
//   ),
//   GoRoute(
//     path: TodoJourneyScreen.routeName,
//     builder: (context, state) => TodoJourneyScreen(extra: state.extra as Map<String, dynamic>?),
//   ),
//   GoRoute(
//     path: DailyCheckInScreen.routeName,
//     builder: (context, state) => DailyCheckInScreen(arguments: state.extra as Map<String, dynamic>?),
//   ),
// ];

// // Provider for journey feature
// List<BlocProvider> journeyProviders() {
//   // Create OpenAI service with API key
//   // In a real app, this would be stored securely and not hardcoded
//   final openAIService = OpenAIService(apiKey: 'your-openai-api-key');
  
//   // Create AI Planner service
//   final aiPlannerService = AIPlannerService(openAIService: openAIService);
  
//   return [
//     BlocProvider<JourneyBloc>(
//       create: (context) => JourneyBloc(aiPlannerService),
//     ),
//   ];
// }

// // Add a button to the dashboard to start the journey
// Widget buildStartJourneyButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       context.push(GoalInputScreen.routeName);
//     },
//     child: const Text('Start AI Journey'),
//   );
// }
