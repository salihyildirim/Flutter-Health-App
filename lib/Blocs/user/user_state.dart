
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}

class UserErrorState extends UserState {
  final String errorMessage;

  UserErrorState({required this.errorMessage});
}
