import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Utils/dialogHelper/dialogHelper.dart';
import 'package:womenhealth/ViewModel/sportViewModel.dart';

class SubSports extends StatefulWidget {
  final String selectedSport;
  SubSports(this.selectedSport);

  @override
  State<SubSports> createState() => _SubSportsState();
}

class _SubSportsState extends State<SubSports> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SportViewModel(),
      builder: (context, w) => Dialog(
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<String>?>(
                  future: context.read<SportViewModel>().getNameFromActivities(widget.selectedSport),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Text('No data available.');
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index]),//turkceye cevirelim.
                              onTap: () {
                                DialogHelper.showSportMinutesDialog(context);
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () async {

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