import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  Future<UserCredential?> signInAnonymously() async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuthInstance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    return userCredential;
  }

  Future<void> signOut() async {
    await firebaseAuthInstance.signOut();
  }
}
