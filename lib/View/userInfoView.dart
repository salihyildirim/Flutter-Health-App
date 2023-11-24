import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:womenhealth/Blocs/user/user_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Model/user.dart';

class UserInfoView extends StatefulWidget {
  final User user;

  UserInfoView({required this.user});

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  int _age = 0;
  int _kg = 0;
  String _gender = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: Scaffold(
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
                Flexible(child: Text('Cinsiyet', style: TextStyle(fontSize: 16.0))),
                Flexible(
                  child: RadioListTile<String>(
                    title: Text('Erkek'),
                    value: 'Erkek',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile<String>(
                    title: Text('Kadın'),
                    value: 'Kadın',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
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
                            cinsiyet: _gender,
                            kg: _kg,
                            yas: _age);
                        context.read<UserBloc>().add(
                            SaveUserToFirestoreEvent(userData: newUser.toMap()));
                      }
                    },
                    child: Text('Kaydet'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
