import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _hasResolvedAuth = false;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasResolvedAuth => _hasResolvedAuth;

  AppState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _isLoggedIn = user != null;
      _hasResolvedAuth = true; // ✅ Auth check done
      notifyListeners();
    });
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    _hasResolvedAuth = true;
    notifyListeners();
  }
}
