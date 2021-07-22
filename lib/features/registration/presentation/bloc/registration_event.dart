part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends RegistrationEvent{
  final String name;
  final String lastName;
  final int docNumber;
  final String email;
  final int phone;
  final DateTime birthDate;
  final File photo;
  RegisterEvent({
    @required this.name, 
    @required this.lastName, 
    @required this.docNumber, 
    @required this.email, 
    @required this.phone, 
    @required this.birthDate, 
    @required this.photo
  });
}
