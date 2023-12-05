import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/View/loginView.dart';
import 'package:womenhealth/View/userInfoView.dart';
import 'package:womenhealth/ViewModel/welcomeViewModel.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WelcomeViewModel>(
      create: (context) => WelcomeViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Welcome Page'),
          actions: [
            PopupMenuButton<String>(
              offset: Offset(0, kToolbarHeight),
              // Menüyü App Bar'ın altında başlatır
              onSelected: (value) {
                // Seçilen değeri kontrol edebilir ve ilgili işlemleri gerçekleştirebilirsiniz.
                if (value == 'edit') {
                  // Düzenleme sayfasına yönlendirme işlemleri burada yapılabilir.
                } else if (value == 'settings') {
                  // Ayarlar sayfasına yönlendirme işlemleri burada yapılabilir.
                } else if (value == 'logout') {
                  context.read<WelcomeViewModel>().signOut();
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    tileColor: Colors.blue,
                    // Menü arka plan rengi
                    leading: Icon(Icons.edit, color: Colors.white),
                    // Ikon rengi
                    title: Text('Düzenle',
                        style: TextStyle(color: Colors.white)), // Yazı rengi
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: ListTile(
                    tileColor: Colors.blue,
                    // Menü arka plan rengi
                    leading: Icon(Icons.settings, color: Colors.white),
                    // Ikon rengi
                    title: Text('Ayarlar',
                        style: TextStyle(color: Colors.white)), // Yazı rengi
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    tileColor: Colors.blue,
                    // Menü arka plan rengi
                    leading: Icon(Icons.logout, color: Colors.white),
                    // Ikon rengi
                    title: Text('Çıkış Yap',
                        style: TextStyle(color: Colors.white)), // Yazı rengi
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {}, child: Text("GEÇMİŞ HESAPLAMALAR")),
              ElevatedButton(
                  onPressed: () {}, child: Text("GÜNLÜK KALORİ HESAPLA")),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
                },
                child: Text('ANA SAYFAYA DÖN'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    User? getUser;
                    firebase_auth.User? currentUser = await context
                        .read<WelcomeViewModel>()
                        .getCurrentUser();
                    if (currentUser != null) {
                      getUser = await context
                          .read<WelcomeViewModel>()
                          .getUser(currentUser.email.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserInfoView(user: getUser!)));
                    }
                    else{
                      print("Kullanici yok");
                    }
                  },
                  child: Text('Bilgilerimi Güncelle'))
            ],
          ),
        ),
      ),
    );
  }
}
