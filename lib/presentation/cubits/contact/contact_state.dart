// File: lib/presentation/cubits/contact/contact_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/contact_entity.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final String message;

  ContactSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactFailure extends ContactState {
  final String errorMessage;

  ContactFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ContactLoaded extends ContactState {
  final List<ContactEntity> contacts;

  ContactLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}
