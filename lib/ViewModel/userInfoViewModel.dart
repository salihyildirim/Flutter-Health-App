
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/Auth.dart';
import 'package:womenhealth/Service/FirestoreService.dart';

class WelcomeViewModel with ChangeNotifier{
  final FirestoreService _firestoreService = FirestoreService('users');
  final Auth _auth=Auth();

  Future<User?> getUser(String documentId) async {
      Map<String, dynamic>? currentUserMap= await _firestoreService.readData(documentId);
      return User.fromMap(currentUserMap as Map<String, dynamic>);

  }

  Future<firebase_auth.User?> getCurrentUser() async {
    return await _auth.getCurrentUser();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
