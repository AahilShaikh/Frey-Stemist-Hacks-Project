import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithGoogle() async {
  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    await FirebaseAuth.instance.signInWithPopup(authProvider);

  } catch (e) {
    print(e);
  }
  
}
