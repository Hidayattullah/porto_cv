import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/contact/contact_cubit.dart';
import '../../cubits/contact/contact_state.dart';
import 'contact_list_item.dart';

class ContactBody extends StatelessWidget {
  const ContactBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the contacts when the widget is built
    context.read<ContactCubit>().getContactsCubit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            if (state.contacts.isEmpty) {
              return const Center(child: Text('No contacts found.'));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                bool isSmallScreen = constraints.maxWidth < 600;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: DataTable(
                      columnSpacing: isSmallScreen ? 10 : 20,
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Message')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: state.contacts.map((contact) {
                        return DataRow(cells: [
                          DataCell(Text(
                            contact.name,
                            style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                          )),
                          DataCell(Text(
                            contact.email,
                            style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                          )),
                          DataCell(Text(
                            contact.message,
                            style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                          )),
                          DataCell(ContactListItem(contact: contact)),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              },
            );
          } else if (state is ContactFailure) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('No contacts found.'));
        },
      ),
    );
  }
}
