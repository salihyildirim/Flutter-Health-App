import 'package:flutter/material.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';

class DialogHelper {

  static void showGramDialog(BuildContext context, Food food, FoodViewModel foodViewModel,User user) {
    int grams = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gram Bilgisi Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  grams = int.tryParse(value) ?? 0;

                },
                decoration: InputDecoration(
                  hintText: 'Gram',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Vazgeç'),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                        foodViewModel.addCaloriesTaken(user, food.food_name,grams);
                      Navigator.of(context).pop();
                    },
                    child: Text('Ekle'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
