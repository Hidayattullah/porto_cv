// File: lib/domain/usecases/contact/add_contact.dart
import '../../entities/contact_entity.dart';
import '../../repositores/contact_repository.dart';

class AddContact {
  final ContactRepository repository;

  AddContact(this.repository);

  Future<void> call(ContactEntity contact) {
    return repository.addContact(contact);
  }
}
