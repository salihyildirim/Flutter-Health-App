import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:womenhealth/LoginView.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginView()));
          },
          child: Text('ANA SAYFAYA DÖN'),
        ),
      ),
    );
  }
}
