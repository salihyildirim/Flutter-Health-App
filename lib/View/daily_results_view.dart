import "package:flutter/material.dart";
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DailyResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Results'),
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
              radius: 150.0,
              lineWidth: 15.0,
              percent: 0.7, // Örnek olarak %70
              center: Text(
                '70%',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
            LinearPercentIndicatorWidget(
              title: 'Carbohydrate',
              percent: 0.3, // Örnek olarak %30
            ),
            LinearPercentIndicatorWidget(
              title: 'Fat',
              percent: 0.2, // Örnek olarak %20
            ),
            LinearPercentIndicatorWidget(
              title: 'Sugar',
              percent: 0.4, // Örnek olarak %40
            ),
            LinearPercentIndicatorWidget(
              title: 'Fiber',
              percent: 0.6, // Örnek olarak %60
            ),
            LinearPercentIndicatorWidget(
              title: 'Sodium',
              percent: 0.7, // Örnek olarak %70
            ),
            LinearPercentIndicatorWidget(
              title: 'Potassium',
              percent: 0.8, // Örnek olarak %80
            ),
            LinearPercentIndicatorWidget(
              title: 'Cholesterol',
              percent: 0.1, // Örnek olarak %10
            ),
          ],
        ),
      ),
    );
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
      child: Row(
        children: [
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
          ),
        ],
      ),
    );
  }
}

//protein , karbonhidrat ,yağ,şeker, lif, sodyum, potasyum, kolestrol.