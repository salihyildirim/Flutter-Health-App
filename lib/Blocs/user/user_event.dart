
abstract class UserEvent {}

class SaveUserToFirestoreEvent extends UserEvent {
  final Map<String, dynamic> userData;

  SaveUserToFirestoreEvent({required this.userData});
}
