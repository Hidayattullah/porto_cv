// File: lib/domain/usecases/contact/get_contact.dart
import '../../entities/contact_entity.dart';
import '../../repositores/contact_repository.dart';

class GetContacts {
  final ContactRepository repository;

  GetContacts(this.repository);

  Future<List<ContactEntity>> call() {
    return repository.getContacts();
  }
}
