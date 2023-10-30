import 'dart:async';

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

  static Future<bool?> loginStatus() async {
    bool? isLogged;
    StreamSubscription<User?>? subscription;

    subscription = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        isLogged = false;
        print('User is currently signed out!');
      } else {
        isLogged = true;
        print('User is signed in!');
      }

      // Dinleme işlemi tamamlandığında aboneliği iptal et
      subscription?.cancel();
    });

    // Bir olayın tamamlanmasını bekler ve sonucu döndürür
    await subscription.asFuture();
    return isLogged;
  }



  Future<void> signOut() async {
    await firebaseAuthInstance.signOut();
  }
}
