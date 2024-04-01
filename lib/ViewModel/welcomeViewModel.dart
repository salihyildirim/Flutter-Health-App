import 'package:get/get.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/Auth.dart';
import 'package:womenhealth/Service/FirestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class WelcomeViewModel extends GetxController {
  final FirestoreService _firestoreService = FirestoreService('users');
  final Auth _auth = Auth();

  Future<User?> getUser(String documentId) async {
    Map<String, dynamic>? currentUserMap =
        await _firestoreService.readData(documentId);
    return User.fromMap(currentUserMap as Map<String, dynamic>);
  }

  Future<firebase_auth.User?> getCurrentUser() async {
    return await _auth.getCurrentUser();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<firebase_auth.User?> authStatus() {
    return _auth.authStatus();
  }

  Future<User?> getCurrentUserDetails() async {
    firebase_auth.User? currentUser = await _auth.getCurrentUser();
    if (currentUser != null) {
      Map<String, dynamic>? userData =
          await _firestoreService.readData(currentUser.uid);

      if (userData != null) {
        return User.fromMap(userData);
      }
    }
    return null;
  }

  Future<String?> getCurrentUserName() async {
    firebase_auth.User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      User? user = await getUser(currentUser.email.toString());
      if (user != null) {
        return user.name; // Kullanıcı adını ve soyadını döndür
      }
    }
    return null;
  }
}
