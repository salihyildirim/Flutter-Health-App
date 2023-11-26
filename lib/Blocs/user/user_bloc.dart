import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());


  @override
  void on<SaveUserToFirestoreEvent>(event, emit) async {
    if (event is SaveUserToFirestoreEvent) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userData['eMail']) // Belki kullanıcının UID'sini kullanmak isteyebilirsiniz
            .set(event.userData);
        emit(UserSuccessState()); // İşlem başarılı oldu
      } catch (e) {
        emit(UserErrorState(errorMessage: e.toString()));
      }
    }
  }
}
