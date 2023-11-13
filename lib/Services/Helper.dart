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
  }
}