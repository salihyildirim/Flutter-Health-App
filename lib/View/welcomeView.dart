import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/Auth.dart';
import 'package:womenhealth/View/foodView.dart';
import 'package:womenhealth/View/userInfoView.dart';
import 'package:womenhealth/ViewModel/foodViewModel.dart';
import 'package:womenhealth/ViewModel/welcomeViewModel.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  User? getUser;
  firebase_auth.User? currentUser;
  int _currentTab = 0;


  Future<void> fetchCurrentUser(BuildContext context) async {
    currentUser = await context.read<WelcomeViewModel>().getCurrentUser();
    getUser = await context
        .read<WelcomeViewModel>()
        .getUser(currentUser!.email.toString());
    setState(() {}); // State'i güncelle
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WelcomeViewModel>(
      create: (context) {
        return WelcomeViewModel();
      },
      builder: (context, _) =>
          Scaffold(
            bottomNavigationBar: AnimatedBottomNavigationBar( height: Get.height / 12,
              //ekranın %12'si. mediaquery yerine get bize yardımcı oluyor.
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              gapLocation: GapLocation.center,
              backgroundColor: Colors.black,
              icons: [Icons.show_chart, Icons.history],
              iconSize: 30,
              activeIndex: _currentTab,
              onTap: (int) {
                setState(() {
                  _currentTab = int;
                  //_currentScreen = (int == 0) ? GraphScreen() : HistoryScreen();
                });
              },),
            appBar: AppBar(
              centerTitle: true,
              title: FutureBuilder<String?>(
                future: Provider.of<WelcomeViewModel>(context)
                    .getCurrentUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('HOŞGELDİN'); // Eğer ad alınana kadar bekle
                  } else {
                    return Text(
                        'HOŞGELDİN ${snapshot.data
                            ?.toUpperCase()}'); // Kullanıcı adını göster
                  }
                },
              ),
              actions: [
                PopupMenuButton<String>(
                  offset: Offset(0, kToolbarHeight),
                  // Menüyü App Bar'ın altında başlatır
                  onSelected: (value) async {
                    //
                    if (value == 'edit') {
                      //
                    } else if (value == 'settings') {
                      //
                    } else if (value == 'logout') {
                      await Provider.of<WelcomeViewModel>(
                          context, listen: false)
                          .signOut();
                      Auth.loginState = false;
                      Provider.of<WelcomeViewModel>(context, listen: false)
                          .authStatus();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  [
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: ListTile(
                        tileColor: Colors.blue,
                        // Menü arka plan rengi
                        leading: Icon(Icons.edit, color: Colors.white),
                        // Ikon rengi
                        title: Text('Düzenle',
                            style: TextStyle(
                                color: Colors.white)), // Yazı rengi
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'settings',
                      child: ListTile(
                        tileColor: Colors.blue,
                        // Menü arka plan rengi
                        leading: Icon(Icons.settings, color: Colors.white),
                        // Ikon rengi
                        title: Text('Ayarlar',
                            style: TextStyle(
                                color: Colors.white)), // Yazı rengi
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        tileColor: Colors.blue,
                        // Menü arka plan rengi
                        leading: Icon(Icons.logout, color: Colors.white),
                        // Ikon rengi
                        title: Text('Çıkış Yap',
                            style: TextStyle(
                                color: Colors.white)), // Yazı rengi
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
                onPressed: () async {
                  await fetchCurrentUser(context);
                  if (currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FoodView(
                                  foodViewModel: FoodViewModel(),
                                  user: getUser!,
                                )));
                  }
                },
                child: Text("GÜNLÜK KALORİ HESAPLA")),
            ElevatedButton(
                onPressed: () async {
                  await fetchCurrentUser(context);
                  if (currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserInfoView(user: getUser!)));
                  } else {
                    print("Kullanici yok");
                  }
                },
                child: Text('Bilgilerimi Güncelle')),
            ],
          ),
    ),)
    ,
    );
  }
}
