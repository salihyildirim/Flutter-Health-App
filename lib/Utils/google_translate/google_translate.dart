import 'package:translator_plus/translator_plus.dart';

class GoogleTranslate {
  static final GoogleTranslate _instance = GoogleTranslate._internal();

  GoogleTranslator _translator = GoogleTranslator();

  factory GoogleTranslate() {
    return _instance;
  }

  GoogleTranslate._internal();

  Future<String> translateToTurkish(String englishText) async {
    try {
      Translation translation = await _translator.translate(englishText, to: 'tr');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return englishText;
    }
  }

  Future<String> translateToEnglish(String turkishText) async {
    try {
      Translation translation = await _translator.translate(turkishText, to: 'en');
      return translation.text;
    } catch (e) {
      print("Çeviri hatası: $e");
      return turkishText;
    }
  }
}
