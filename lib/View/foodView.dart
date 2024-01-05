import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/food.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Utils/data/local_food_database.dart';
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

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  void filterFoods(String query) {
    setState(() {
      filteredFoods = foods
          .where((food) =>
          food.food_name.toLowerCase().contains(query.toLowerCase()))
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
            return FutureBuilder<double?>(
              future: widget.foodViewModel.getCaloriesFromFood(
                  filteredFoods[index].food_name),
              builder: (BuildContext context, AsyncSnapshot<double?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Ya da herhangi bir yükleme göstergesi.
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return ListTile(
                    title: Text(
                      "${filteredFoods[index].food_name} ${snapshot.data ??
                          'Veri bulunamadı'}",
                    ),
                    // ... (ListTile içeriğinin geri kalanı)
                  );
                }
              },
            );
          },
        ),

      ),
      MaterialButton(
        onPressed: () {
          widget.foodViewModel.removeNullValues();
        }, child: Text("LIST NOW"),),
      ],
    ),)
    ,
    );
  }
}
