import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Blocs/user/user_bloc.dart';
import 'package:womenhealth/Service/Auth.dart';
import 'package:womenhealth/View/loginView.dart';
import 'package:womenhealth/View/welcomeView.dart';
import 'package:womenhealth/ViewModel/loginViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        // İhtiyaç duyulan diğer Provider'ları buraya ekleyebilirsiniz.
      ],
      child: MyApp(),
    ),
  );
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
    Auth.loginStatus(); // uygulama ilk baslarken login kontrolü yapılır.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModelProvider = Provider.of<LoginViewModel>(context,
        listen:
            false); //dependency injection.Verilen yayının nesnesini singleton olarak aldık.
    return StreamBuilder<User?>(
        stream: loginViewModelProvider.authStatus(),
        // buradaki streamden gelen veride bir değişiklik olur olmaz builder yeniden çizilir. devamlı dinliyor.
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? WelcomeView()
                : LoginView(); //son gelen veri(data)yani User, null mu?
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
