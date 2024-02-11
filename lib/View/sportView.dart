import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Utils/widgets/subsports.dart';
import 'package:womenhealth/ViewModel/sportViewModel.dart';

class SportView extends StatefulWidget {
  User user;
  SportView(this.user);

  @override
  _SportViewState createState() => _SportViewState();
}

class _SportViewState extends State<SportView> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SportViewModel>(
      create: (BuildContext context) {
        return SportViewModel();
      },
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Sport View"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Filtreleme işlemi burada gerçekleştirilir
                  setState(() {
                    context.read<SportViewModel>().filterSports(value);
                  });

                },
                decoration: InputDecoration(
                  labelText: 'Search Sports',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
              },
              child: Text("Your Button"),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: context.read<SportViewModel>().translateSportListToTurkishParallel(),
                builder: (context, snapshot) {
                  List<String> sportsToShow = context.read<SportViewModel>().filteredSports;

                  return ListView.builder(
                    itemCount: sportsToShow.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(sportsToShow[index]),
                        onTap: ()async {
                          String selectedSport= await context.read<SportViewModel>().translateToEnglish(sportsToShow[index]);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Özel bir widget oluştur ve içerisinde istediğiniz içeriği göster
                              return SubSports(selectedSport,widget.user);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context, String sportType) async {
    TextEditingController _minutesController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Minutes for $sportType"),
          content: TextFormField(
            controller: _minutesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Minutes"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String minutes = _minutesController.text;
                print("Selected $sportType for $minutes minutes");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
