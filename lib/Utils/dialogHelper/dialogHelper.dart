import 'package:flutter/material.dart';
import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';

class DialogHelper {

  static Future<UserDiet?> showGramDialog(BuildContext context, Food food, FoodViewModel foodViewModel, User user) async {
    int grams = 0;
    UserDiet? userDiet;

    userDiet = await showDialog(
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
                      Navigator.of(context).pop(null);
                    },
                    child: Text('Vazgeç'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      userDiet = await foodViewModel.addFirebaseUserDietCaloriesTaken(user, food.name, grams);
                      Navigator.pop(context, userDiet);
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

    return userDiet;
  }

  static Future<String?> showSportMinutesDialog(BuildContext context) async {
    TextEditingController minuteController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spor Dakikası'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minuteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Dakika'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Vazgeç butonu
                    },
                    child: Text('Vazgeç'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // OK butonu işlemleri burada yapılabilir.
                      String enteredMinutes = minuteController.text;
                      Navigator.pop(context, enteredMinutes); // Girilen dakika değerini döndür
                    },
                    child: Text('OK'),
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
