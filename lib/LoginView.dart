import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/LoginViewModel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (BuildContext context) { return LoginViewModel(); },
      builder:(context,_)=> Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Uygulama Başlığı'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<LoginViewModel>(context, listen: false)
                      .signOut();
                },
                icon: Icon(Icons.exit_to_app)),
            IconButton(
              icon: Icon(Icons.language, size: 26),
              onPressed: () {
                // Kullanıcının dil seçimini yapması için bir dialog veya sayfa açabilirsiniz.
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Giriş Yap",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Kullanıcı Adı",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  UserCredential? userCredential =
                  await Provider.of<LoginViewModel>(context, listen: false)
                      .signInAnonymously();
                  print(userCredential);
                },
                child: Text("GİRİŞ YAP"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
