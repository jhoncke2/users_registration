import 'dart:io';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/domain/use_cases/register.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  static const SERVER_FAILURE_MESSAGE = 'Ha ocurrido un error al enviar la información al servidor';

  final Register register;
  RegistrationBloc({
    @required this.register
  }) : super(OnEmptyRegistration());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if(event is RegisterEvent){
      yield OnLoadingRegistration();
      final User user = User(
        name: event.name,
        lastName: event.lastName,
        docNumber: event.docNumber,
        email: event.email,
        phone: event.phone,
        birthDate: event.birthDate,
        photo: event.photo
      );
      final eitherRegister = await register(RegisterParams(user: user));
      yield * eitherRegister.fold((failure)async*{
        yield OnRegistrationError(message: SERVER_FAILURE_MESSAGE);
        yield * _yieldOnEmptyRegistration();
      }, (_)async*{
        yield OnSuccessfulyRegistrated();
        yield * _yieldOnEmptyRegistration();
      });
      
    }
  }

  Stream<RegistrationState> _yieldOnEmptyRegistration()async*{
    yield await Future.delayed(Duration(milliseconds: 2000), ()=> OnEmptyRegistration());
  }
}
