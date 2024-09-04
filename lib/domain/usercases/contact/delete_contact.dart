// File: lib/domain/usecases/contact/delete_contact.dart
import '../../repositores/contact_repository.dart';

class DeleteContact {
  final ContactRepository repository;

  DeleteContact(this.repository);

  Future<void> call(String contactId) {
    return repository.deleteContact(contactId);
  }
}
