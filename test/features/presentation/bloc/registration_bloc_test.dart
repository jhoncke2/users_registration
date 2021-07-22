import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/domain/use_cases/register.dart';
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

    test('debe lanzar los estados ordenados como se especifica', ()async{
      final expectedOrderedStates = [
        OnLoadingRegistration(),
        OnSuccessfulyRegistrated()
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