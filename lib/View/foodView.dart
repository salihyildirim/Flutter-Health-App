import 'package:flutter/material.dart';
import 'package:womenhealth/Model/food.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late List<Food> foods = [
    Food("food1", "EKMEK", 250),
    Food("food1", "elma", 115),
    Food("food1", "armut", 51.2),
    Food("food1", "kek", 55.2),
    Food("food1", "saman", 58),
    Food("food1", "Küçük Zeynep", 275),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredFoods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(

                  ),
                  title: Text("${filteredFoods[index].food_name}      " + "      ${filteredFoods[index].food_calory}"),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Burada ekleme işlemi yapılabilir.
                      // Örneğin: Sepete ekle, favorilere ekle, vb.
                      // onPressed içine eklenecek kodları yazmalısın.
                      print('Eklendi: ${filteredFoods[index].food_name}' + ' ${filteredFoods[index].food_calory}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
