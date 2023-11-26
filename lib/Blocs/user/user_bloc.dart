import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:womenhealth/Blocs/user/user_event.dart';
import 'package:womenhealth/Blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<SaveUserToFirestoreEvent>(onSaveUserToFirestore);
  }

  void onSaveUserToFirestore(
      SaveUserToFirestoreEvent event, Emitter<UserState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.userData['eMail'])
          .set(event.userData);
      emit(UserSuccessState()); // İşlem başarılı oldu
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }
}
