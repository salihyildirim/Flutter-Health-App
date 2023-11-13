import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Services/Auth.dart';

class RegisterViewModel with ChangeNotifier{
  Auth auth = Auth();

  Future<User?> createWithEmail (String email, String password) async{
    Future<User?> currentUser= auth.createWithEmail(email, password);
    return currentUser;
  }
}