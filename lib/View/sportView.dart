import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Utils/widgets/subsports.dart';
import 'package:womenhealth/View/daily_results_view.dart';
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
            Expanded(
              flex: 1,
              child: Padding(
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
            ),
            Expanded(
              flex: 9,
              child: FutureBuilder<List<String>>(
                future: context
                    .read<SportViewModel>()
                    .translateSportListToTurkishParallel(),
                builder: (context, snapshot) {
                  List<String> sportsToShow =
                      context.read<SportViewModel>().filteredSports;
                  return ListView.builder(
                    itemCount: sportsToShow.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(sportsToShow[index]),
                        onTap: () async {
                          String selectedSport = await context
                              .read<SportViewModel>()
                              .translateToEnglish(sportsToShow[index]);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Özel bir widget oluştur ve içerisinde istediğiniz içeriği göster.
                              return SubSports(selectedSport, widget.user);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DailyResultsView()));
              },//buraya gecerken database'e kaydetmiş olduğun userDiet nesnesini ilet.
              child: Text("ILERI"),
            ))
          ],
        ),
      ),
    );
  }
}
