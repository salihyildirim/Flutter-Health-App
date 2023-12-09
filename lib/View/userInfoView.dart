
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:womenhealth/Blocs/user/user_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/View/welcomeView.dart';



enum SelectedGender { male, female, other }

extension GenderExtension on SelectedGender {
  String get value {
    switch (this) {
      case SelectedGender.male:
        return 'Erkek';
      case SelectedGender.female:
        return 'Kadın';
      case SelectedGender.other:
        return 'Diger';
    }
  }
}
SelectedGender stringToGender(String genderString) {
  switch (genderString.toLowerCase()) {
    case 'kadın':
      return SelectedGender.female;
    case 'erkek':
      return SelectedGender.male;
    case 'diger':
      return SelectedGender.other;
    default:
      return SelectedGender.male; // Varsayılan olarak erkek seçiliyor
  }
}


class UserInfoView extends StatefulWidget {
  final User user;

  UserInfoView({required this.user});

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = '';
  int _age = 0;
  int _kg = 0;
  late SelectedGender _selectedGender=SelectedGender.male;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _kgController = TextEditingController();


  @override
  void initState() {
    _firstName=widget.user.name;
    _lastName=widget.user.surName;
    _age=widget.user.yas;
    _kg=widget.user.kg;
    _selectedGender = stringToGender(widget.user.cinsiyet);



    _nameController.text = _firstName;
    _surNameController.text = _lastName;
    _ageController.text = _age.toString();
    _kgController.text = _kg.toString();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Formu'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Ad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen adınızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: _surNameController,
                  decoration: InputDecoration(labelText: 'Soyad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen soyadınızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Yaş'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen yaşınızı girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.parse(value!);
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: _kgController,
                  decoration: InputDecoration(labelText: 'Kilo'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen kilonuzu girin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _kg = int.parse(value!);
                  },
                ),
              ),
              Flexible(
                  child: Text('Cinsiyet', style: TextStyle(fontSize: 16.0))),
              Flexible(
                child: RadioListTile<SelectedGender>(
                  title: Text('Erkek'),
                  value: SelectedGender.male,
                  groupValue: _selectedGender,
                  onChanged: (SelectedGender? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<SelectedGender>(
                  title: Text('Kadın'),
                  value: SelectedGender.female,
                  groupValue: _selectedGender,
                  onChanged: (SelectedGender? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!
                          .save(); //formların onSave methodnu çağırır
                      // Form doğrulandı ve kaydedildi, işlemler yapılabilir
                      // context.read<UserBloc>().add(SaveUserToFirestoreEvent(userData: newUser.toMap()));
                      //fakat tüm alanlarını doldurup kaydet.
                      User newUser = User(
                        eMail: widget.user.eMail,
                        password: widget.user.password,
                        name: _firstName,
                        surName: _lastName,
                        cinsiyet: _selectedGender.value,
                        kg: _kg,
                        yas: _age,
                        registerDate: widget.user.registerDate,
                      );
                      BlocProvider.of<UserBloc>(context).add(
                          SaveUserToFirestoreEvent(userData: newUser.toMap()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeView()));
                    }
                  },
                  child: Text('Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
