import 'package:womenhealth/Model/User_Diet.dart';

class User {
  String eMail; // email,firestore Id olarak kaydedilecek.
  String password;
  String name;
  String surName;
  String cinsiyet;
  int kg;
  int yas;
  DateTime registerDate;
  UserDiet? userDiet;

  User({
    required this.eMail,
  required this.password,
    required this.name,
    required this.surName,
    required this.cinsiyet,
    required this.kg,
    required this.yas,
    required this.registerDate,
    required this.userDiet
  });

  Map<String, dynamic> toMap() {
    return {
      'eMail': eMail,
      'password':password,
      'name': name,
      'surName': surName,
      'cinsiyet': cinsiyet,
      'kg': kg,
      'yas': yas,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      eMail: map['eMail'],
      password: map['password'],
      name: map['name'],
      surName: map['surName'],
      cinsiyet: map['cinsiyet'],
      kg: map['kg'],
      yas: map['yas'],
      registerDate: map['registerDate'],
      userDiet: map['userDiet']
    );
  }
}
