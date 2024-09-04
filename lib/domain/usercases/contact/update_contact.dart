// File: lib/domain/usecases/contact/update_contact.dart
import '../../entities/contact_entity.dart';
import '../../repositores/contact_repository.dart';

class UpdateContact {
  final ContactRepository repository;

  UpdateContact(this.repository);

  Future<void> call(ContactEntity contact) {
    return repository.updateContact(contact);
  }
}
