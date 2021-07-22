part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [];
}

class OnEmptyRegistration extends RegistrationState {}

class OnLoadingRegistration extends RegistrationState{}

class OnSuccessfulyRegistrated extends RegistrationState{}
