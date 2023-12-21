import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Service/FirestoreService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class FoodViewModel with ChangeNotifier{
  final FirestoreService _firestoreService = FirestoreService('foods');

  Future<void> createData(Map<String, dynamic> data) async {
    await _firestoreService.createData(data);
  }

  Future<Map<String, dynamic>?> readData(String documentId) async {
    return await _firestoreService.readData(documentId);

  }

  Future<void> updateData(
      String documentId, Map<String, dynamic> newData) async {
    await _firestoreService.updateData(documentId, newData);
  }

  Future<void> deleteData(String documentId) async {
    await _firestoreService.deleteData(documentId);
  }
  void fetchNutritionInfo() async {
    String query = "Elma".tr().toString();
    String encodedQuery = Uri.encodeQueryComponent(query);
    String apiKey = "fU9y72p/j2sGb2Tdw0j6/g==E0H80ltgZ4HNggFB";

    var url = Uri.parse("https://api.api-ninjas.com/v1/nutrition?query=$encodedQuery");

    var response = await http.get(
      url,
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      print(response.body); // Cevabı konsola yazdırın
      // İşlemlerinize devam edebilirsiniz
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

}
