import 'package:flutter/material.dart';

class SubSportView extends StatelessWidget {
  final List<String> subSports;

  SubSportView({required this.subSports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Sports"),
      ),
      body: ListView.builder(
        itemCount: subSports.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subSports[index]),
            onTap: () {
              print("Tapped on: ${subSports[index]}");
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> mainSports = [
    "Football",
    "Basketball",
    "Tennis",
    // ... diğer ana sporlar
  ];

  final Map<String, List<String>> subSports = {
    "Football": ["Soccer", "American Football", "Rugby"],
    "Basketball": ["NBA", "Street Basketball", "3x3"],
    "Tennis": ["Singles", "Doubles", "Mixed Doubles"],
    // ... diğer sporlar ve alt dalları
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Sports"),
      ),
      body: ListView.builder(
        itemCount: mainSports.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mainSports[index]),
            onTap: () {
              String mainSport = mainSports[index];
              List<String> subSportList = subSports[mainSport] ?? [];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubSportView(subSports: subSportList),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
