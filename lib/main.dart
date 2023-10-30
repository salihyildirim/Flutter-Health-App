import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/LoginView.dart';
import 'package:womenhealth/LoginViewModel.dart';
import 'package:womenhealth/Services/Auth.dart';
import 'package:womenhealth/WelcomeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<bool?> currentLoginStatus;

  @override
  void initState() {
    super.initState();
    currentLoginStatus = Auth.loginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (context, _) {
        if (currentLoginStatus == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (currentLoginStatus == true) {
          return WelcomeView();
        } else
          return LoginView();
      },
    );
  }
}
