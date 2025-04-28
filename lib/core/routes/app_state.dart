import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:loop/feature/auth/data/datasources/auth_service.dart';

 class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _hasResolvedAuth = false;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasResolvedAuth => _hasResolvedAuth;

  AppState() {

    FirebaseAuth.instance.authStateChanges().listen((user) async{
      _isLoggedIn = user != null;
      _hasResolvedAuth = true;
      notifyListeners();
    });
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    _hasResolvedAuth = true;
    notifyListeners();
  }
}
