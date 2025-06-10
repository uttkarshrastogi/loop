import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/services/injection.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/prefrence_utils.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  // await dotenv.load(fileName: ".env");
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseAuth.instance.useAuthEmulator("localhost", 5001);
    // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }
  setupLocator();
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child:  MyApp(),
    ),
  );
}