import 'package:firebase_auth/firebase_auth.dart';
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
  runApp(ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Auth.loginStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _loginViewModelProvider = Provider.of<LoginViewModel>(context,
        listen:
            false); //dependency injection.Verilen yayının nesnesini singleton olarak aldık.
    return StreamBuilder<User?>(
        stream: _loginViewModelProvider.authStatus(),
        // buradaki streamden gelen veride bir değişiklik olur olmaz builder yeniden çizilir. devamlı dinliyor.
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? WelcomeView()
                : LoginView(); //son gelen veri(data)yani User null mu?
          } else {
            return SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
