import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static bool ? loginState;
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
    loginState=isLogged; //global login durumunu güncelledim.
    return isLogged;
  }
  Future<User?> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Current user: ${user.uid}');
      return user;
    } else {
      print('No user currently logged in.');
      return null;
    }
  }

  Future<void> signOut() async {
    await firebaseAuthInstance.signOut();
  }

  Stream<User?> authStatus() {
    return firebaseAuthInstance.authStateChanges();
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user; // UserCredential'dan User nesnesini döndür.
    } catch (e) {
      print("Hata oluştu: $e");
      return null; // Giriş başarısız olduğunda null döndür.
    }
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
