import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Utils/data/local_food_database.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';

class FoodView extends StatefulWidget {
  final FoodViewModel foodViewModel; // FoodViewModel'i parametre olarak ekle

  const FoodView({Key? key, required this.foodViewModel}) : super(key: key);

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late List<Food> foods = [];
  late List<Food> filteredFoods = [];

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  void filterFoods(String query) {
    setState(() {
      filteredFoods = foods
          .where(
              (food) => food.food_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void fetchFoods() async {
    var turkishFoods = await widget.foodViewModel.getAllTurkishFoods();
    List<Food> foodList = [];
    for (var foodName in turkishFoods) {
      Food newFood = Food("food_id", foodName, "food_photo_url", 55);
      foodList.add(newFood);
    }
    setState(() {
      foods = foodList;
      filteredFoods = foodList;
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
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${filteredFoods[index].food_name} ${filteredFoods[index].food_calory}",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                      context.read<FoodViewModel>().fetchNutritionInfo(filteredFoods[index].food_name);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
