import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Utils/dialogHelper/dialogHelper.dart';
import 'package:womenhealth/View/sportView.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';

class FoodView extends StatefulWidget {
  final FoodViewModel foodViewModel; // FoodViewModel'i parametre olarak ekle
  final User user;

  const FoodView({Key? key, required this.foodViewModel, required this.user})
      : super(key: key);

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late List<Food> foods = [];
  late List<Food> filteredFoods = [];
  GoogleTranslator translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  void filterFoods(String query) {
    setState(() {
      filteredFoods = foods
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void fetchFoods() async {
    List<String> turkishFoods = await widget.foodViewModel.getAllTurkishFoods();
    List<Food> foodList = [];
    for (var foodName in turkishFoods) {
      Food newFood = Food("id", foodName, "photo_url", 55,55,55,55,55,55,55,55,55,55);
      foodList.add(newFood);
    }
    setState(() {
      foods = foodList;
      //  filteredFoods = foodList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => filterFoods(value),
          decoration: InputDecoration(
            hintText: 'Yiyecek Ara...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => FoodViewModel(),
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Map<String, dynamic>?>(
                    initialData: null,
                    future: widget.foodViewModel.getNutritionFromFood(filteredFoods[index].name),
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Veri yüklenirken göstermek için bir yükleme göstergesi ekleyin
                      } else if (snapshot.hasError) {
                        return Text('Hata: ${snapshot.error}');
                      } else {
                        var nutritionData = snapshot.data;
                        if (nutritionData == null) {
                          return Text('Veri bulunamadı');
                        }

                        double? calories = nutritionData['calories'];

                        return ListTile(
                          title: Text(
                            "${filteredFoods[index].name} (${calories?.toStringAsFixed(2) ?? 'Veri bulunamadı'} cal).",
                          ),
                          onTap: () async {
                            UserDiet? userDiet =
                            await DialogHelper.showGramDialog(
                                context,
                                filteredFoods[index],
                                widget.foodViewModel,
                                widget.user);
                            widget.user.userDiet = userDiet;
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ButtonTheme(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(SportView(widget.user));
                  },
                  child: Text("İLERİ"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
