// File: lib/domain/repositories/contact_repository.dart
import '../entities/contact_entity.dart';

abstract class ContactRepository {
  Future<void> addContact(ContactEntity contact);
  Future<void> deleteContact(String contactId);
  Future<List<ContactEntity>> getContacts();
  Future<void> updateContact(ContactEntity contact);
}
