import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a String value
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Retrieve a String value
  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Save a Boolean value
  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Retrieve a Boolean value
  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Save an Integer value
  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Retrieve an Integer value
  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Save a Double value
  static Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  // Retrieve a Double value
  static double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  // Remove a key
  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all preferences
  static Future<void> clear() async {
    await _preferences?.clear();
  }
}

