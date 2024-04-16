import 'package:flutter/cupertino.dart';

class Food {
  String id;
  String name;
  String photo_url;
  double calories;
  double fat_total_g;
  double fat_saturated_g;
  double protein_g;
  double sodium_mg;
  double potassium_mg;
  double cholesterol_mg;
  double carbohydrates_total_g;
  double fiber_g;
  double sugar_g;

  Food(
      this.id,
      this.name,
      this.photo_url,
      this.calories,
      this.fat_total_g,
      this.fat_saturated_g,
      this.protein_g,
      this.sodium_mg,
      this.potassium_mg,
      this.cholesterol_mg,
      this.carbohydrates_total_g,this.fiber_g,this.sugar_g);
}
