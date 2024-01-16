import 'package:flutter/cupertino.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:http/http.dart' as http;


class SportViewModel with ChangeNotifier {
  GoogleTranslator translator = GoogleTranslator();
  final nutritionApiKey = "fU9y72p/j2sGb2Tdw0j6/g==E0H80ltgZ4HNggFB";


  Future<String> translateToTurkish(String text) async {
    try {
      Translation translation = await translator.translate(text, to: 'tr');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return text;
    }
  }
  Future<String?> fetchNutritionBody(String sportName) async {
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

}
