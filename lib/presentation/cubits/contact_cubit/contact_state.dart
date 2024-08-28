abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactSubmitted extends ContactState {
  final String message;

  ContactSubmitted(this.message);
}
