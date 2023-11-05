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

  static bool? loginStatus() {
    bool? isLogged;
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        isLogged = false;
        print('User is currently signed out!');
      } else {
        isLogged = true;
        print('User is signed in!');
      }
    });
    return isLogged;
  }

  Future<void> signOut() async {
    await firebaseAuthInstance.signOut();
  }

  Stream<User?> authStatus() {
    return firebaseAuthInstance.authStateChanges();
  }

  Future<User?> createWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }
      return userCredential.user; // UserCredential'dan User nesnesini döndür.
    } catch (e) {
      print("Hata oluştu: $e");
      return null; //
    }
  }
}
