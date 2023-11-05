import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Services/Auth.dart';

class LoginViewModel with ChangeNotifier {
  Auth auth = Auth();

  Future<UserCredential?> signInAnonymously() async {
    UserCredential? userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  bool? loginStatus() {
    return Auth.loginStatus();
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<User?> authStatus() {
    return auth.authStatus();
  }
  Future<User?> createWithEmail (String email, String password) async{
    Future<User?> currentUser= auth.createWithEmail(email, password);
    return currentUser;
  }
}
