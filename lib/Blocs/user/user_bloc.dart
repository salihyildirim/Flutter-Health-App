// user_bloc.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());


Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SaveUserToFirestoreEvent) {
      print("if (event is SaveUserToFirestoreEvent) içine girdi");
      // Firestore'a kullanıcıyı kaydet
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userData['eMail']) // Belki kullanıcının UID'sini kullanmak isteyebilirsiniz
            .set(event.userData);
        yield UserSuccessState(); // İşlem başarılı oldu
      } catch (e) {
        yield UserErrorState(errorMessage: e.toString());
      }
    }
    else{
      print("Girmedi");
    }
  }
}
