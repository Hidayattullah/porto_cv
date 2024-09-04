import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/datasources/contact_datasource.dart';
import '../data/repositories/contact_repository_impl.dart';
import '../domain/usercases/contact/add_contact.dart';
import '../domain/usercases/contact/delete_contact.dart';
import '../domain/usercases/contact/get_contact.dart';
import '../domain/usercases/contact/update_contact.dart';
import '../presentation/cubits/contact/contact_cubit.dart';

List<BlocProvider> provideContactDependencies() {
  final firestore = FirebaseFirestore.instance;
  
  // Membuat instance dari ContactDataSourceImpl
  final contactDataSource = ContactDataSourceImpl(firestore);
  
  // Membuat instance dari ContactRepositoryImpl dengan contactDataSource sebagai parameter
  final contactRepository = ContactRepositoryImpl(contactDataSource);

  return [
    BlocProvider<ContactCubit>(
      create: (context) => ContactCubit(
        addContact: AddContact(contactRepository),
        deleteContact: DeleteContact(contactRepository),
        getContacts: GetContacts(contactRepository),
        updateContact: UpdateContact(contactRepository),
      ),
    ),
  ];
}
