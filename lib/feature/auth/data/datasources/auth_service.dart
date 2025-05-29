import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  class AuthService {
   Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(["tokenutt", googleUser.serverAuthCode]);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Firestore user creation logic
      final user = userCredential.user;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
      return userCredential;
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }
   Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut(); // Sign out from Google account
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase session
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
