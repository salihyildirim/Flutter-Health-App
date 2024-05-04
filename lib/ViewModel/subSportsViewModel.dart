import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/FirestoreService.dart';

class SubSportsViewModel with ChangeNotifier {
//burada userdiet nesnesini alıp, database'e given_calories kısmına ekle(addFirebaseUserDietCaloriesGiven). bunun için user_email lazım.
//direkt user nesnesini alırsan önceki işlemlerde user.userdiet dogru atandı. onu kullanabilirsin.
//aynı zamanda email'i de userden alırsın.
  final FirestoreService _firestoreService = FirestoreService('userdiet');

  Future<Map<String, dynamic>?> readUserDiet(String documentId) async {
    return await _firestoreService.readData(documentId);
  }

  Future<List<Map<String, dynamic>>> readUserDietDaily(
      String documentId) async {
    return await _firestoreService.readDataFromSubcollection(documentId);
  }

  Future<List<Map<String, dynamic>>?> fetchUserDietDaily(
      String documentId) async {
    List<Map<String, dynamic>> userDietDailyList =
        await readUserDietDaily(documentId);
    if (userDietDailyList.isNotEmpty) {
      return userDietDailyList;
    } else {
      return null;
    }
  }

  Future<void> createDataWithCustomId(
      Map<String, dynamic> data, String documentId) async {
    await _firestoreService.createDataWithCustomId(documentId, data);
  }

  Future<void> createSubcollectionData(
      {required String documentId,
      String subcollectionName = "daily_calculations",
      required Map<String, dynamic> data}) async {
    _firestoreService.createSubcollectionData(
        documentId: documentId, data: data);
  }

  Future<void> updateUserDiet(
      String documentId, Map<String, dynamic> newData) async {
    await _firestoreService.updateData(documentId, newData);
  }

  Future<void> addFirebaseUserDietCaloriesGiven(
      User user, double givenCalories) async {
    List<Map<String, dynamic>>? userDietDailyList = await fetchUserDietDaily(
        user.eMail); // burda artık ilgili user'in daily_calculations
    //listesi geliyor. en sondakinin tarihi bugün mü? öyleyse oraya ekle. değilse yeni döküman oluştur oraya ekle.

    // BURADA YAPMAN GEREKEN : FETCH EDILEN USERDIETIN calculation_date == bugün mü?
    //evet ise yeni bir döküman oluştur.
    //değil ise o dökümanı çek ve update et.

    DateTime today = DateTime.now();

    DateTime lastDocumentDate =
        DateTime.parse(userDietDailyList!.last['calculation_date']);

    if (givenCalories > 0) {
      if (user.userDiet == null ||
          lastDocumentDate.year != today.year &&
              lastDocumentDate.month != today.month &&
              lastDocumentDate.day != today.day) {
        UserDiet userDiet = UserDiet(
          calories_given: givenCalories,
          calculation_date: DateTime.now(),
        );
        user.userDiet = userDiet;
        createSubcollectionData(
            documentId: user.eMail, data: user.userDiet!.toMap());

        //createDataWithCustomId(user.userDiet!.toMap(), user.eMail);
        //tam burada yeni oluşturduğumuz userdiet'i kaydet.
      } else {
        user.userDiet!.calories_given =
            (user.userDiet!.calories_given ?? 0) + givenCalories;

        //user.userDiet 'i database'e güncelle.
        _firestoreService.updateSubCollectionData(
          newData: user.userDiet!.toMap(),
          documentId: user.eMail,
        );
      }
    }
  }
}
