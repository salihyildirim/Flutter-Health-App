import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/ViewModel/sportViewModel.dart';

class SubSports extends StatelessWidget {
  String selectedSport;
  SubSports(this.selectedSport);
  List<String>? selectedSportSubList = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SportViewModel(),
      builder:(context,w)=> Dialog(
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedSport),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    selectedSportSubList = await context.read<SportViewModel>().getNameFromActivities(selectedSport);
                    print(selectedSportSubList!.length);
                  },
                  child: Text("ffff"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
