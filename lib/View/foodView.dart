import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_plus/translator_plus.dart';
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
  String textt= "Hello World";

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
    List<String> turkishFoods = await widget.foodViewModel.getAllTurkishFoods();
    List<Food> foodList = [];
    for (var foodName in turkishFoods) {
      Food newFood = Food("food_id", foodName, "food_photo_url", 55);
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
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<double?>(
                    initialData: 0.0,
                    future: widget.foodViewModel
                        .getCaloriesFromFood(filteredFoods[index].food_name),
                    builder: (BuildContext context,
                        AsyncSnapshot<double?> snapshot) {
                      return ListTile(
                        title: Text(
                          "${filteredFoods[index].food_name} ${snapshot.data ?? 'Veri bulunamadı'}",
                        ),
                        onTap: () {
                          DialogHelper.showGramDialog(
                              context,
                              filteredFoods[index],
                              widget.foodViewModel,
                              widget.user);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Text(textt),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SportView()));
              },
              child: Text("ILERI"),
            ),
          ],
        ),
      ),
    );
  }

}
