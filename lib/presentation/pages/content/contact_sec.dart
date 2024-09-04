import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../cubits/contact/contact_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
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
                    final contact = ContactEntity(
                      id: _uuid.v4(), // Menghasilkan UUID untuk id
                      name: _nameController.text,
                      email: _emailController.text,
                      message: _messageController.text, 
                    );

                    context.read<ContactCubit>().addContact(contact);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message Sent!')),
                    );

                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  }
                },
                child: const Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
