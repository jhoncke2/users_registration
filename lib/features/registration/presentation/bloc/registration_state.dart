part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [this.runtimeType];
}

class OnEmptyRegistration extends RegistrationState {}

class OnLoadingRegistration extends RegistrationState{}

class OnSuccessfulyRegistrated extends RegistrationState{}

class OnRegistrationError extends RegistrationState{
  final String message;
  OnRegistrationError({
    @required this.message
  });
  @override
  List<Object> get props => [...super.props, this.message];
}