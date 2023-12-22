import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Utils/data/local_food_database.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late List<Food> foods = [
  ];

  late List<Food> filteredFoods = [];

  void filterFoods(String query) {
    setState(() {
      filteredFoods = foods
          .where(
              (food) => food.food_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return FoodViewModel(); },
      builder: (context, _) => Scaffold(
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${filteredFoods[index].food_name}      " "      ${filteredFoods[index].food_calory}"),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                       context.read<FoodViewModel>().fetchNutritionInfo("Elma");
                        print('Eklendi: ${filteredFoods[index].food_name}' ' ${filteredFoods[index].food_calory}');
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
