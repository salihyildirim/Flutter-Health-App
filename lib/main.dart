import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/LoginViewModel.dart';

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(),
        builder: (context, _) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Uygulama Başlığı'),
                actions: [
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
                      onPressed: () {},
                      child: Text("GİRİŞ YAP"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ));
  }
}
