import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/RegisterViewModel.dart';
import 'package:womenhealth/UserInfoView.dart';
import 'package:womenhealth/WelcomeView.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerFormKey = GlobalKey<FormState>();

    return ChangeNotifierProvider<RegisterViewModel>(
      create: (BuildContext context) => RegisterViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text('Üye Kaydı'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return 'Lütfen geçerli bir adres giriniz.';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'E-posta'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Şifre boş bırakılamaz!';
                    } else if (value.length < 6) {
                      return 'Şifre en az 6 karakter olmalıdır.';
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Şifre'),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Şifreler uyuşmuyor !";
                    } else {
                      return null;
                    }
                  },
                  controller: confirmPasswordController,
                  decoration:
                      InputDecoration(labelText: 'Şifreyi Tekrar Girin'),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (registerFormKey.currentState!.validate()) {
                      User? user = await context
                          .read<RegisterViewModel>()
                          .createWithEmail(
                              emailController.text, passwordController.text);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserInfoView(),
                          ),
                        );
                      }
                      else{
                        //kayıt esnasında bir hata oluştu.
                      }
                    }
                  },
                  child: Text('Kayıt Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
