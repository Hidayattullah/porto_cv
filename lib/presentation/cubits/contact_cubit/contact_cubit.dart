import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void submitContactForm(String message) {
    // Simulate form submission
    emit(ContactSubmitted(message));
  }
}
