import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Service/FirestoreService.dart';

class SubSportsViewModel {
//burada userdiet nesnesini alıp, database'e given_calories kısmına ekle(addFirebaseUserDietCaloriesGiven). bunun için user_email lazım.
//direkt user nesnesini alırsan önceki işlemlerde user.userdiet dogru atandı. onu kullanabilirsin.
//aynı zamanda email'i de userden alırsın.
  final FirestoreService _firestoreService = FirestoreService('userdiet');

  Future<Map<String, dynamic>?> readUserDiet(String documentId) async {
    return await _firestoreService.readData(documentId);
  }

  Future<UserDiet?> fetchUserDiet(String documentId) async {
    Map<String, dynamic>? userDietMap = await readUserDiet(documentId);
    if (userDietMap != null) {
      UserDiet userDiet = UserDiet.fromMap(userDietMap);
      return userDiet;
    } else {
      return null;
      print("userDiet çekilemedi.");
    }
  }

  Future<void> createDataWithCustomId(
      Map<String, dynamic> data, String documentId) async {
    await _firestoreService.createDataWithCustomId(documentId, data);
  }

  Future<void> updateUserDiet(
      String documentId, Map<String, dynamic> newData) async {
    await _firestoreService.updateData(documentId, newData);
  }

}
