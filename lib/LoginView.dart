import 'package:email_validator/email_validator.dart';
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
  bool? isLogged;
  bool isSigningIn = false; // Başlangıçta giriş işlemi aktif değil.
  Future<void> _signInButtonOnPressed() async {
    if (!isSigningIn) {
      // Giriş işlemi zaten devam etmiyorsa
      setState(() {
        isSigningIn = true; // Giriş işlemi başladı.
      });

      UserCredential? userCredential =
          await Provider.of<LoginViewModel>(context, listen: false)
              .signInAnonymously();

      setState(() {
        isSigningIn = false; // Giriş işlemi tamamlandı.
        if (userCredential != null) {
          isLogged = true;
          print("TRUE YANI ABONE= ${userCredential.user?.uid}");
        } else {
          isLogged = false;
          print("Giriş başarısız.");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final _registerFormKey=GlobalKey<FormState>();

    return ChangeNotifierProvider<LoginViewModel>(
      create: (BuildContext context) {
        isLogged =
            Provider.of<LoginViewModel>(context, listen: false).loginStatus();
        return LoginViewModel();
      },
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Uygulama Başlığı'),
          actions: [
            IconButton(
              onPressed: () async {
                await Provider.of<LoginViewModel>(context, listen: false)
                    .signOut();
                setState(() {
                  isLogged = false;
                });
              },
              icon: Icon(Icons.exit_to_app),
            ),
            IconButton(
              icon: Icon(Icons.language, size: 26),
              onPressed: () {
                // Kullanıcının dil seçimini yapması için bir dialog veya sayfa açabilirsiniz.
              },
            ),
          ],
        ),
        body: Center(
          child: Form(
            key: _registerFormKey,
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
                TextFormField(validator: (value){
                  if(!EmailValidator.validate(value!)){
                    return 'Lütfen geçerli bir adres giriniz.';
                  }
                  return null;
                },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(validator: (value){
                  if (value!.isEmpty) {
                    return 'Şifre boş bırakılamaz!';
                  } else if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır.';
                  }
                  return null;
                },
                  controller: passController,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLogged == true ? null : _signInButtonOnPressed,
                  child: Text("GİRİŞ YAP"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    User? user;
                    if (_registerFormKey.currentState!.validate()) {
                    user = await context
                        .read<LoginViewModel>()
                        .createWithEmail(
                            emailController.text, passController.text);}
                    if(user!=null){
                      setState(() {
                        isLogged = false;
                      });
                    }
                  },
                  child: Text("E-Mail ile Kayıt Yap"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
