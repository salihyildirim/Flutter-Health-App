import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class LocalFood {
  var filePath = 'assets/translations/en-US.json'; // Değiştirilecek dosya yolu

  Future<List<String>> turkceYemekler() async {
    // Assets içindeki JSON dosyasını okuyun
    String jsonString = await rootBundle.loadString(filePath);

    // JSON formatındaki verileri haritaya dönüştür
    Map<String, dynamic> data = json.decode(jsonString);

    // Sadece anahtarları (keys) alarak bir liste oluştur
    List<String> keys = data.keys.toList();

    // Anahtarları dön
    return keys;
  }
}
