// File: lib/data/models/contact_model.dart
import '../../../domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.name,
    required super.email,
    required super.message,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map, String id) {
    return ContactModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
}
