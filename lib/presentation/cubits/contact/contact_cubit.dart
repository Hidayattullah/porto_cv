// File: lib/presentation/cubits/contact/contact_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porto_cv/domain/usercases/contact/add_contact.dart';
import 'package:porto_cv/domain/usercases/contact/delete_contact.dart';
import 'package:porto_cv/domain/usercases/contact/get_contact.dart';
import 'package:porto_cv/domain/usercases/contact/update_contact.dart';
import '../../../domain/entities/contact_entity.dart';
import 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final AddContact addContact;
  final DeleteContact deleteContact;
  final GetContacts getContacts;
  final UpdateContact updateContact;

  ContactCubit({
    required this.addContact,
    required this.deleteContact,
    required this.getContacts,
    required this.updateContact,
  }) : super(ContactInitial());

  Future<void> sendContactCubit(ContactEntity contact) async {
    emit(ContactLoading());
    try {
      await addContact(contact);
      emit(ContactSuccess('Contact sent successfully.'));
    } catch (e) {
      emit(ContactFailure(e.toString()));
    }
  }

  Future<void> deleteContactCubit(String contactId) async {
    emit(ContactLoading());
    try {
      await deleteContact(contactId);
      emit(ContactSuccess('Contact deleted successfully.'));
    } catch (e) {
      emit(ContactFailure(e.toString()));
    }
  }

  Future<void> getContactsCubit() async {
    emit(ContactLoading());
    try {
      final contacts = await getContacts();
      emit(ContactLoaded(contacts));
    } catch (e) {
      emit(ContactFailure(e.toString()));
    }
  }

  Future<void> updateContactCubit(ContactEntity contact) async {
    emit(ContactLoading());
    try {
      await updateContact(contact);
      emit(ContactSuccess('Contact updated successfully.'));
    } catch (e) {
      emit(ContactFailure(e.toString()));
    }
  }
}
