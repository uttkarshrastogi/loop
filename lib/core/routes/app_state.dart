// app_state.dart
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isInitialized = false;
  bool _isLoggedIn = false;
  bool _isQuestionnaireFilled = false;

  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _isLoggedIn;
  bool get isQuestionnaireFilled => _isQuestionnaireFilled;

  AppState() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Simulate some initialization delay
    await Future.delayed(Duration(seconds: 1));

    // Check for token
    _isLoggedIn = await _checkForToken();

    // If logged in, check questionnaire status
    if (_isLoggedIn) {
      _isQuestionnaireFilled = await _checkQuestionnaireStatus();
    }

    _isInitialized = true;
    notifyListeners();
  }

  Future<bool> _checkForToken() async {
    // Implement your token retrieval logic here
    // Return true if token exists, false otherwise
    // For demonstration, we'll assume the user is not logged in
    return false;
  }

  Future<bool> _checkQuestionnaireStatus() async {
    // Implement your questionnaire status check here
    // Return true if questionnaire is filled, false otherwise
    // For demonstration, we'll assume it's not filled
    return false;
  }

  // Methods to update the state, e.g., after login or questionnaire completion
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void completeQuestionnaire() {
    _isQuestionnaireFilled = true;
    notifyListeners();
  }
}
