import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../cubits/auth/auth_state.dart';
import '../../cubits/contact/contact_cubit.dart';
import '../../cubits/auth/auth_cubit.dart'; // Import AuthCubit untuk memeriksa status login
import '../contact/contact_body.dart';

class ContactSec extends StatefulWidget {
  const ContactSec({super.key});

  @override
  _ContactSecState createState() => _ContactSecState();
}

class _ContactSecState extends State<ContactSec> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final Uuid _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar secara dinamis
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send me an Email'),
        actions: [
          // Periksa apakah pengguna sudah login
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactBody()),
                    );
                  },
                );
              }
              return const SizedBox.shrink(); // Sembunyikan tombol jika tidak login
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight, // Set minimum height sesuai dengan tinggi layar
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.9, // Set width sesuai ukuran layar
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _messageController,
                          decoration: const InputDecoration(labelText: 'Message'),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newContact = ContactEntity(
                                id: _uuid.v4(),
                                name: _nameController.text,
                                email: _emailController.text,
                                message: _messageController.text,
                              );

                              context.read<ContactCubit>().addContact(newContact);

                              // Tampilkan pesan berhasil
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Message sent!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );

                              // Bersihkan form setelah pengiriman
                              _nameController.clear();
                              _emailController.clear();
                              _messageController.clear();

                              // Refresh ulang halaman
                              setState(() {});
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
