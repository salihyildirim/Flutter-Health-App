import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDiet {
  int? id;
  DateTime calculation_date; // foreign key for user table
  double calories_taken;
  double calories_given;
  double summation; // taken - given + olarak toplandıgında


  UserDiet({
    this.calories_taken = 0,
    this.calories_given = 0,
    this.summation = 0,
    required this.calculation_date,
  });

  UserDiet.withId({
    this.id,
    this.calories_taken = 0,
    this.calories_given = 0,
    this.summation = 0,
    required this.calculation_date,});

  Map<String, dynamic> toMap() {
    var map= Map<String,dynamic>();
      map['calories_taken']= calories_taken;
      map['calories_given']= calories_given;
      map['summation']= summation;
      map['calculation_date']= Timestamp.fromDate(calculation_date);
      if(id!=null){
        map["id"]=id;
      }
      return map;
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
