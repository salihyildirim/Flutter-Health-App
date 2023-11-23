import 'package:womenhealth/Model/user.dart';

abstract class UserEvent{}

class AddUser extends UserEvent{
  final User user;

  AddUser({required this.user});
}