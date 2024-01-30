import 'package:flutter/material.dart';

class SubSports extends StatelessWidget {
  String selectedSport;
  SubSports(this.selectedSport);


//tıklandığında subsportlar görünecek.
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        widthFactor: 1, // Genişlik için %80
        heightFactor: 0.8, // Yükseklik için %80
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedSport),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
