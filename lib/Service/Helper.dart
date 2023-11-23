import 'package:flutter/material.dart';

class Helper {
  static void showErrorDialog(BuildContext context,String text1,String text2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text1),
          content: Text(text2),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } // Harcanan kalori = (MET değeri x 3.5 x kilo (kg) x süre (dakika)) / 200

  double toplamKalori(double MET,int kg,int dakika,String cinsiyet,){
    if(cinsiyet=="ERKEK"){
      return (MET*3.5*kg*dakika);
    }
    if(cinsiyet=="KADIN"){
      return (MET*3.5*kg*dakika)*0.9;
    }
    else {
      return 0;
    }
  }
}