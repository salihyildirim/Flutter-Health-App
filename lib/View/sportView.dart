import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/ViewModel/sportViewModel.dart';

class SportView extends StatefulWidget {
  @override
  _SportViewState createState() => _SportViewState();
}

class _SportViewState extends State<SportView> {
  List<String> sportTypes = ["Football", "Basketball", "Tennis", "Running"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SportViewModel>(
      create: (BuildContext context) {
        return SportViewModel();
      },
      builder: (context,child)=> Scaffold(
        appBar: AppBar(
          title: Text("Sport View"),
        ),
        body: Column(
          children: [
            // Add your text and button here
            Text(
              "Your Text Here",
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () async{
                context.read<SportViewModel>().digerSporlariEle();

               // String turkce= await context
               //      .read<SportViewModel>()
               //      .translateToTurkish(sonuc);
               //
               // print("turkcesi: $turkce");

              },
              child: Text("Your Button"),
            ),
            // ListView.builder for sportTypes
            Expanded(
              child: ListView.builder(
                itemCount: sportTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sportTypes[index]),
                    onTap: () {
                      _showInputDialog(context, sportTypes[index]);
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
