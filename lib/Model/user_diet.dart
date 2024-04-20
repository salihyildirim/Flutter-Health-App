import 'package:cloud_firestore/cloud_firestore.dart';

class UserDiet {
  dynamic calculation_date; // Hem DateTime hem de String olabilir
  double? calories_taken;
  double? calories_given;
  double? carbohydrates_total_g;
  int? cholesterol_mg;
  double? fat_total_g;
  double? fiber_g;
  int? potassium_mg;
  double? protein_g;
  int? sodium_mg;
  double? sugar_g;

  UserDiet({
    this.calories_taken = 0,
    this.calories_given = 0,
    this.carbohydrates_total_g = 0,
    this.cholesterol_mg = 0,
    this.fat_total_g = 0,
    this.fiber_g = 0,
    this.potassium_mg = 0,
    this.protein_g = 0,
    this.sodium_mg = 0,
    this.sugar_g = 0,
    this.calculation_date,
  });

  Map<String, dynamic> toMap({bool forFirebase = false}) {
    var map = Map<String, dynamic>();
    map['calories_taken'] = calories_taken;
    map['calories_given'] = calories_given;
    map['carbohydrates_total_g'] = carbohydrates_total_g;
    map['cholesterol_mg'] = cholesterol_mg;
    map['fat_total_g'] = fat_total_g;
    map['fiber_g'] = fiber_g;
    map['potassium_mg'] = potassium_mg;
    map['protein_g'] = protein_g;
    map['sodium_mg'] = sodium_mg;
    map['sugar_g'] = sugar_g;

    if (forFirebase) {
      map['calculation_date'] =
          Timestamp.fromDate(DateTime.parse(calculation_date));
    } else {
      map['calculation_date'] = calculation_date.toString();
    }

    return map;
  }

  factory UserDiet.fromMap(Map<String, dynamic> map) {
    return UserDiet(
      calories_taken: map['calories_taken'] ?? 0.0,
      calories_given: map['calories_given'] ?? 0.0,
      carbohydrates_total_g: map['carbohydrates_total_g'] ?? 0.0,
      cholesterol_mg: map['cholesterol_mg'] ?? 0.0,
      fat_total_g: map['fat_total_g'] ?? 0.0,
      fiber_g: map['fiber_g'] ?? 0.0,
      potassium_mg: map['potassium_mg'] ?? 0.0,
      protein_g: map['protein_g'] ?? 0.0,
      sodium_mg: map['sodium_mg'] ?? 0.0,
      sugar_g: map['sugar_g'] ?? 0.0,
      calculation_date: map['calculation_date'] is Timestamp
          ? (map['calculation_date'] as Timestamp).toDate()
          : map['calculation_date'],
    );
  }
}
