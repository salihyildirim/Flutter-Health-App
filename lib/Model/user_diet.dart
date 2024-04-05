import 'package:cloud_firestore/cloud_firestore.dart';

class UserDiet {
  int? id;
  dynamic calculation_date; // Hem DateTime hem de String olabilir
  double? calories_taken;
  double? calories_given;
  double? summation;

  UserDiet({
    this.calories_taken = 0,
    this.calories_given = 0,
    this.summation = 0,
    this.calculation_date,
  });

  UserDiet.withId({
    this.id,
    this.calories_taken = 0,
    this.calories_given = 0,
    this.summation = 0,
    required this.calculation_date,
  });

  Map<String, dynamic> toMap({bool forFirebase = false}) {
    var map = Map<String, dynamic>();
    map['calories_taken'] = calories_taken;
    map['calories_given'] = calories_given;
    //map['summation'] = summation;

    if (forFirebase) {
      map['calculation_date'] =
          Timestamp.fromDate(DateTime.parse(calculation_date));
    } else {
      map['calculation_date'] = calculation_date.toString();
    }

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  factory UserDiet.fromMap(Map<String, dynamic> map) {
    return UserDiet(
      calories_taken: map['calories_taken'] ?? 0.0,
      calories_given: map['calories_given'] ?? 0.0,
      summation: map['summation'] ?? 0.0,
      calculation_date: map['calculation_date'] is Timestamp
          ? (map['calculation_date'] as Timestamp).toDate()
          : map['calculation_date'],
    );
  }

  UserDiet.fromObject(dynamic o) {
    id = int.tryParse(o["id"].toString());
    calories_taken = double.tryParse(o['calories_taken'].toString()) ?? 0;
    calories_given = double.tryParse(o['calories_given'].toString()) ?? 0;
    summation = double.tryParse(o['summation'].toString()) ?? 0;
    calculation_date = o['calculation_date'];
  }
}
