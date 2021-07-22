import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/domain/use_cases/register.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';
import 'package:registro_usuarios/features/registration/presentation/bloc/registration_bloc.dart';
import '../../../fixtures/user.dart' as userFixtures;

class MockRegister extends Mock implements Register{}
RegistrationBloc bloc;
MockRegister register;

void main(){
  setUp((){
    register = MockRegister();
    bloc = RegistrationBloc(register: register);
  });

  group('registerEvent', (){
    User tUser;
    setUp((){
      tUser = userFixtures.user;
    });

    test('debe llamar los métodos esperados', ()async{
      when(register(any)).thenAnswer((realInvocation) async => Right(null));
      bloc.add(RegisterEvent(
        name: tUser.name, 
        lastName: tUser.lastName, 
        docNumber: tUser.docNumber, 
        email: tUser.email, 
        phone: tUser.phone, 
        birthDate: tUser.birthDate, 
        photo: tUser.photo
      ));
      await untilCalled(register(any));
      verify(register(RegisterParams(user: tUser)));
    });

    test('debe lanzar los estados ordenados como se especifica cuando todo sale bien', ()async{
      when(register(any)).thenAnswer((realInvocation) async => Right(null));
      final expectedOrderedStates = [
        OnLoadingRegistration(),
        OnSuccessfulyRegistrated(),
        OnEmptyRegistration()
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expectedOrderedStates));
      bloc.add(RegisterEvent(
        name: tUser.name, 
        lastName: tUser.lastName, 
        docNumber: tUser.docNumber, 
        email: tUser.email, 
        phone: tUser.phone, 
        birthDate: tUser.birthDate, 
        photo: tUser.photo
      ));
    });

    test('debe lanzar los estados ordenados como se especifica cuando el useCase retorna un Left(Failure())', ()async{
      when(register(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      final expectedOrderedStates = [
        OnLoadingRegistration(),
        OnRegistrationError(message: RegistrationBloc.SERVER_FAILURE_MESSAGE),
        OnEmptyRegistration()
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expectedOrderedStates));
      bloc.add(RegisterEvent(
        name: tUser.name, 
        lastName: tUser.lastName, 
        docNumber: tUser.docNumber, 
        email: tUser.email, 
        phone: tUser.phone, 
        birthDate: tUser.birthDate, 
        photo: tUser.photo
      ));
    });
  });
}