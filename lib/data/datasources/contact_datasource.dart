// File: lib/data/datasources/contact_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/contact/contact_model.dart';

abstract class ContactDataSource {
  Future<void> addContact(ContactModel contact);
  Future<void> deleteContact(String contactId);
  Future<List<ContactModel>> getContacts();
  Future<void> updateContact(ContactModel contact);
}

class ContactDataSourceImpl implements ContactDataSource {
  final FirebaseFirestore firestore;

  ContactDataSourceImpl(this.firestore);

  @override
  Future<void> addContact(ContactModel contact) async {
    await firestore.collection('contacts').doc(contact.id).set(contact.toMap());
  }

  @override
  Future<void> deleteContact(String contactId) async {
    await firestore.collection('contacts').doc(contactId).delete();
  }

  @override
  Future<List<ContactModel>> getContacts() async {
    final querySnapshot = await firestore.collection('contacts').get();
    return querySnapshot.docs.map((doc) {
      return ContactModel.fromMap(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<void> updateContact(ContactModel contact) async {
    await firestore.collection('contacts').doc(contact.id).update(contact.toMap());
  }
}
