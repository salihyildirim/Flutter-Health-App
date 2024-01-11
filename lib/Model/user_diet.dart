import 'package:cloud_firestore/cloud_firestore.dart';

class UserDiet {
  double calories_taken;
  double calories_given;
  double summation;
  DateTime calculation_date;

  UserDiet({
    this.calories_taken = 0,
    this.calories_given = 0,
    this.summation=0,
    required this.calculation_date,
  });

  Map<String, dynamic> toMap() {
    return {
      'calories_taken': calories_taken,
      'calories_given': calories_given,
      'summation': summation,
      'calculation_date': Timestamp.fromDate(calculation_date),
    };
  }

  factory UserDiet.fromMap(Map<String, dynamic> map) {
    return UserDiet(
      calories_taken: map['calories_taken'] ?? 0.0,
      calories_given: map['calories_given'] ?? 0.0,
      summation: map['summation'] ?? 0.0,
      calculation_date: (map['calculation_date'] as Timestamp).toDate(),
    );
  }

}
