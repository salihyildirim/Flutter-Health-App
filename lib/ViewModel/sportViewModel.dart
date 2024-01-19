import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:http/http.dart' as http;

class SportViewModel with ChangeNotifier {
  GoogleTranslator translator = GoogleTranslator();
  final nutritionApiKey = "fU9y72p/j2sGb2Tdw0j6/g==E0H80ltgZ4HNggFB";

  // sports_list.dart

  List<String> sportsList = [
    "Acrobatics",
    "Aerobic Gymnastics",
    "Archery",
    "Arnis",
    "Artistic Gymnastics",
    "Artistic Swimming",
    "Badminton",
    "Baseball",
    "Basketball",
    "Baton Twirling",
    "Bicycle Motocross (BMX)",
    "Billiards/ Pool (U.S.)",
    "Bobsleigh",
    "Bodybuilding",
    "Bowling",
    "Boxing",
    "Canoeing",
    "Car Racing",
    "Cheerleading",
    "Chess",
    "Cricket",
    "Croquet",
    "Curling",
    "Dance Sport",
    "Darts",
    "Diving",
    "Dodgeball",
    "Fencing",
    "Figure Skating",
    "Football (U.K)/ Soccer (U.S., Australia)",
    "Frisbee",
    "Golf",
    "Handball",
    "Hang Gliding",
    "Hockey",
    "Horseback Riding",
    "Horse Racing",
    "Ice Hockey",
    "Ice Skating",
    "Jet Ski Racing",
    "Judo",
    "Karate",
    "Kayaking",
    "Kendo",
    "Kick Boxing",
    "Kite Surfing",
    "Lacrosse",
    "Luge",
    "Mixed Martial Arts",
    "Motocross",
    "Muay Thai",
    "Paintball",
    "Parachuting",
    "Paragliding",
    "Parkour",
    "Polo",
    "Pool/Billiards",
    "Powerlifting",
    "Rafting",
    "Rhythmic Gymnastics",
    "Rock Climbing",
    "Rowing",
    "Rugby",
    "Sailing",
    "Sandboarding",
    "Scuba Diving",
    "Shooting",
    "Skateboarding",
    "Skeleton",
    "Skiing",
    "Snowboarding",
    "Softball",
    "Speed Skating",
    "Sport Climbing",
    "Squash",
    "Sumo Wrestling",
    "Surfing",
    "Swimming",
    "Synchronized Skating",
    "Synchronized Swimming",
    "Table Tennis",
    "Taekwondo",
    "Tennis",
    "Track and Field",
    "Trampolining",
    "Triathlon (Tetrathlon, etc.)",
    "Tug of War",
    "Volleyball",
    "Water Polo",
    "Weightlifting",
    "Windsurfing",
    "Wrestling",
    "Wu Shu",
  ];

  Future<String> translateToTurkish(String text) async {
    try {
      Translation translation = await translator.translate(text, to: 'tr');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return text;
    }
  }

  Future<String?> fetchActivitiesResponseBody(
      String sportName, double weight, double durationMinutes) async {
    String query = sportName.toString();
    String encodedQuery = Uri.encodeQueryComponent(query);

    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/caloriesburned?activity=$encodedQuery&weight=$weight&duration=$durationMinutes");
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

  Future<List<String>?> getNameFromActivities(
      String sportName, double weight, double durationMinutes) async {
    var activitiesBody =
        await fetchActivitiesResponseBody(sportName, weight, durationMinutes);
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

  void digerSporlariEle() async {
    for (var item in sportsList) {
      String? sonuc = await fetchActivitiesResponseBody(item, 100, 60);
      if (sonuc != null) {
        // Sonuç içerisinde bulunan "name" değerini yazdır
        printNameFromJson(sonuc);
      }
    }
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
