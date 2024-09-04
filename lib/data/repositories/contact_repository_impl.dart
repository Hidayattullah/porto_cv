import '../../domain/repositores/contact_repository.dart';
import '../datasources/contact_datasource.dart';
import '../../domain/entities/contact_entity.dart';
import '../model/contact/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource dataSource;

  ContactRepositoryImpl(this.dataSource);

  @override
  Future<void> addContact(ContactEntity contact) async {
    final contactModel = ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      message: contact.message,
    );
    await dataSource.addContact(contactModel);
  }

  @override
  Future<void> deleteContact(String contactId) async {
    await dataSource.deleteContact(contactId);
  }

  @override
  Future<List<ContactEntity>> getContacts() async {
    final contactModels = await dataSource.getContacts();
    return contactModels.map((model) => ContactEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      message: model.message,
    )).toList();
  }

  @override
  Future<void> updateContact(ContactEntity contact) async {
    final contactModel = ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      message: contact.message,
    );
    await dataSource.updateContact(contactModel);
  }
}
