import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/domain/repository/registration_repository.dart';
import 'package:registro_usuarios/features/registration/domain/use_cases/register.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';
import '../../../fixtures/user.dart' as userFixtures;

class MockRegistrationRepository extends Mock implements RegistrationRepository{}

Register useCase;
MockRegistrationRepository repository;

void main(){
  User tUser;
  setUp((){
    repository = MockRegistrationRepository();
    useCase = Register(repository: repository);
    tUser = userFixtures.user;
  });

  test('debe llamar los métodos especificados', ()async{
    await useCase(RegisterParams(user: tUser));
    verify(repository.register(tUser));
  });

  test('debe retornar el resultado esperado cuando el repositorio retorna respuesta positiva', ()async{
    when(repository.register(any)).thenAnswer((realInvocation) async => Right(null));
    final result = await useCase(RegisterParams(user: tUser));
    expect(result, Right(null));
  });
  
  test('debe retornar el resultado esperado cuando el respositorio returna un Failure', ()async{
    when(repository.register(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
    final result = await useCase(RegisterParams(user: tUser));
    expect(result, Left(ServerFailure()));
  });
}