import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/FirestoreService.dart';

class SubSportsViewModel with ChangeNotifier{
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

  Future<void> addFirebaseUserDietCaloriesGiven (User user,double givenCalories)async {

    UserDiet? gettingUserDiet = await fetchUserDiet(user.eMail);
    user.userDiet = gettingUserDiet;

    if(givenCalories>0){
      if (user.userDiet == null) {
        UserDiet userDiet = UserDiet(
          calories_given: givenCalories,
          calculation_date: DateTime.now(),
        );
        user.userDiet = userDiet;
        createDataWithCustomId(user.userDiet!.toMap(), user.eMail);
        //tam burada yeni oluşturduğumuz userdiet'i kaydet.
      } else {
        user.userDiet!.calories_given =
            (user.userDiet!.calories_given ?? 0) + givenCalories;

        //user.userDiet 'i database'e kaydet.
        updateUserDiet(user.eMail, user.userDiet!.toMap());
      }
    }

  }

}
