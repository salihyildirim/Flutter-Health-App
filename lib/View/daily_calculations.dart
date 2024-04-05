import "package:flutter/material.dart";
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:womenhealth/Model/user_diet.dart';
import 'package:womenhealth/data/dbHelper.dart';

class DailyCalculationsView extends StatefulWidget {
  @override
  State<DailyCalculationsView> createState() => _DailyCalculationsViewState();
}

class _DailyCalculationsViewState extends State<DailyCalculationsView> {
  var dbHelper = DbHelper();
  List<UserDiet> userDiets = [];
  int userDietCount = 0;

  @override
  void initState() {
    super.initState();
    getUserDiets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getCalculatedDiets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            userDiets = snapshot.data!;
            userDietCount = userDiets.length;
          } else {
            // Veri yoksa veya hata oluştuysa buraya bir işlem ekleyebilirsiniz
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Daily Results'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Calories',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 40.0,
                  percent: 0.6,
                  // Örnek olarak %70
                  center: Text(
                    '70%',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  progressColor: Colors.blue,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Nutrients',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                LinearPercentIndicatorWidget(
                  title: 'Protein',
                  percent: 0.5, // Örnek olarak %50
                ),
                // Diğer LinearPercentIndicatorWidget'lar
                ElevatedButton(
                  onPressed: () async {
                    addUserDiet();
                  },
                  child: Text("EKLE"),
                ),
                SizedBox(height: 20.0),
                Text(
                  'User Diets',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                // ListView.builder'ı burada ekleyin
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userDiets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          'Calories Given: ${userDiets[index].calories_given}'),
                      subtitle: Text(
                          'Calories Taken: ${userDiets[index].calories_taken}'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addUserDiet() async {
    dbHelper.insert(UserDiet(
        calories_given: 100,
        calories_taken: 100,
        calculation_date: DateTime.now()));
    setState(() {
      // Eklenen diyeti görmek için yeniden setState çağrısı yapılır
    });
  }

  getUserDiets() async {
    var userDietsFuture = dbHelper.getCalculatedDiets();
    userDietsFuture.then((data) {
      if (mounted) {
        setState(() {
          userDiets = data;
          userDietCount = data.length;
                });
      }
    });
  }
}

class LinearPercentIndicatorWidget extends StatelessWidget {
  final String title;
  final double percent;

  const LinearPercentIndicatorWidget({
    required this.title,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            flex: 5,
            child: LinearPercentIndicator(
              percent: percent,
              lineHeight: 20.0,
              backgroundColor: Colors.grey,
              progressColor: Colors.green,
              center: Text('${(percent * 100).toInt()}%'),
            ),
          )
        ]));
  }
}
