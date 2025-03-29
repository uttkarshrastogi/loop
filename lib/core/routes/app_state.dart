import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  // Or listen to Firebase auth directly:
  AppState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _isLoggedIn = user != null;
      notifyListeners();
    });
  }
}
