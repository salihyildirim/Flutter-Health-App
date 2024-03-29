import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:http/http.dart' as http;

class SportViewModel with ChangeNotifier {
  GoogleTranslator translator = GoogleTranslator();
  final nutritionApiKey = "fU9y72p/j2sGb2Tdw0j6/g==E0H80ltgZ4HNggFB";
  List<String> filteredSports = [];
  Map<String, String> translationCache = {};

  static List<String> sportsList = [
    "Archery",
    "Badminton",
    "Softball",
    "Baseball",
    "Basketball",
    "Soccer",
    "Bowling",
    "Cricket",
    "Shuffleboard",
    "Boxing",
    "Martial arts",
    "Camping",
    "Whitewater rafting",
    "Croquet",
    "Curling",
    "Darts",
    "Diving",
    "Children's games",
    "Fencing",
    "Frisbee",
    "Golf",
    "Handball",
    "Hockey",
    "Horseback riding",
    "Horse racing",
    "Skating",
    "Kayaking",
    "Lacrosse",
    "Sledding",
    "Polo",
    "Climbing",
    "Rowing machine",
    "Canoeing",
    "Rugby",
    "Windsurfing",
    "Sailing",
    "Skateboarding",
    "Skiing",
    "Squash",
    "Swimming",
    "Table tennis",
    "Track and field",
    "Volleyball",
  ];

  void filterSports(String query) async {
    // Çevirileri paralel olarak al
    List<String> translatedSports = await translateSportListToTurkishParallel();

    // Çevrilen sporları kullanarak filtrele
    filteredSports = translatedSports
        .where((sport) => sport.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Değişiklikleri dinleyen widget'lara haber ver
    notifyListeners();
  }

  Future<String> translateToTurkish(String englishText) async {
    try {
      Translation translation =
          await translator.translate(englishText, to: 'tr');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return englishText;
    }
  }

  Future<String> translateToEnglish(String turkishText) async {
    try {
      Translation translation =
          await translator.translate(turkishText, to: 'en');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return turkishText;
    }
  }

  // Future<List<String>> translateSportListToTurkish() async {
  //   List<String> turkishList = [];
  //   for (String sport in sportsList) {
  //     String turkishWord = await translateToTurkish(sport);
  //     turkishList.add(turkishWord);
  //   }
  //   return turkishList;
  // }

  Future<List<String>> translateSportListToTurkishParallel() async {
    // translateSportListToTurkish methodundan farklı olarak,
    //translateToTurkish fonksiyonunu her spor için çağırarak tüm çevirileri paralel olarak gerçekleştirir.
    // Future.wait metodu, tüm Future'ların tamamlanmasını bekleyen bir Future döndürür.
    // Bu, çeviri işlemlerini paralel olarak yürütmenin etkili bir yoludur.
    if (translationCache.isNotEmpty) {
      // Eğer önbellekte veri varsa, önbellekten al
      return translationCache.values.toList();
    }
    final List<String> turkishList = [];
    final List<Future<String>> translationFutures = [];

    for (String sport in sportsList) {
      translationFutures.add(translateToTurkish(sport));
    }

    // Future.wait ile tüm çeviri işlemlerini paralel olarak bekliyoruz
    List<String> translations = await Future.wait(translationFutures);

    for (int i = 0; i < sportsList.length; i++) {
      //sıralı şekilde dönsün diye. future esnasında bozulabilir sıra.
      turkishList.add(translations[i]);
      translationCache[sportsList[i]] = translations[i];
    }

    return turkishList;
  }

  Future<String?> fetchNonParametersActivitiesResponseBody(
      String sportName) async {
    String query = sportName.toString();
    String encodedQuery = Uri.encodeQueryComponent(query);

    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/caloriesburned?activity=$encodedQuery");
    var response = await http.get(
      url,
      headers: {
        'X-Api-Key': nutritionApiKey,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<String?> fetchActivitiesResponseBody(
      String sportName, double weight, double durationMinutes) async {
    String query = sportName.toString();
    String encodedQuery = Uri.encodeQueryComponent(query);

    double weightToPounds = weight * 2.20462;
    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/caloriesburned?activity=$encodedQuery&weight=$weightToPounds&duration=$durationMinutes");
// [{"name": "Handball", "calories_per_hour": 544, "duration_minutes": 60, "total_calories": 544}, {"name": "Handball, team", "calories_per_hour": 362, "duration_minutes": 60, "total_calories": 362}]
    var response = await http.get(
      url,
      headers: {
        'X-Api-Key': nutritionApiKey,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<List<String>?> getTurkishNameFromActivities(String sportName) async {
    String? activitiesBody =
        await fetchNonParametersActivitiesResponseBody(sportName);
    List<String> listOfActivityName = [];

    if (activitiesBody != null) {
      var jsonResponse = json.decode(activitiesBody);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        for (var item in jsonResponse) {
          String toBeAdded = await translateToTurkish(item['name']);
          listOfActivityName.add(toBeAdded);
        }
        print("listOfActivityName = $listOfActivityName");
        return listOfActivityName;
      }
    }
    return null;
  }

  Future<List<String>?> getNameFromActivities(String sportName) async {
    String? activitiesBody =
        await fetchNonParametersActivitiesResponseBody(sportName);
    List<String> listOfActivityName = [];

    if (activitiesBody != null) {
      var jsonResponse = json.decode(activitiesBody);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        for (var item in jsonResponse) {
          listOfActivityName.add(item['name']);
        }
        print("listOfActivityName = $listOfActivityName");
        return listOfActivityName;
      }
    }
    return null;
  }

  Future<double> getCalorieFromAnActivity(String sportName, String subSportName,
      double weight, String? durationMinutes) async {
    double durationMinutes2 = double.parse(durationMinutes ?? "0");

    String? activitiesBody =
        await fetchActivitiesResponseBody(sportName, weight, durationMinutes2);
    if (activitiesBody != null) {
      var jsonResponse = json.decode(activitiesBody);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        for(var item in jsonResponse){
          if(item['name']==subSportName){
            return (item['total_calories']).toDouble();
          }
        }
      }
    }return 0;
  }

  void printNameFromJson(String jsonStr) {
    List<dynamic> activities = json.decode(jsonStr);
    for (var activity in activities) {
      if (activity.containsKey('name')) {
        print('Name: ${activity['name']}');
      }
    }
  }
}
