import 'package:google_sign_in/google_sign_in.dart';

class CalendarAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );

  static Future<bool> isConnected() async {
    try {
      return await _googleSignIn.isSignedIn();
    } catch (e) {
      return false;
    }
  }
}
