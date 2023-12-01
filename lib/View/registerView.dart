import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Blocs/user/user_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/View/userInfoView.dart';
import 'package:womenhealth/ViewModel/registerViewModel.dart';

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
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
                      firebase_auth.User? registerUser = await context
                          .read<RegisterViewModel>()
                          .createWithEmail(emailController.text, passwordController.text);

                      if (registerUser != null) {
                        User newUser = User(
                          eMail: emailController.text,
                          password: passwordController.text,
                          name: '',
                          surName: '',
                          cinsiyet: '',
                          kg: 0,
                          yas: 0,
                          registerDate: DateTime.now(),
                          userDiet: null

                        );
                        context.read<UserBloc>().add(SaveUserToFirestoreEvent(userData: newUser.toMap()));
                        BuildContext currentContext = context;

                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            currentContext,
                            MaterialPageRoute(
                              builder: (context) => UserInfoView(user: newUser),
                            ),
                          );
                        });
                      } else {
                        print("registerUser null geldi");
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
