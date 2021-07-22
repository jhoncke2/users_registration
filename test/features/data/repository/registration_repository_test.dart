import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:registro_usuarios/features/registration/data/data_sources/registration_remote_data_source.dart';
import 'package:registro_usuarios/features/registration/data/models/user_model.dart';
import 'package:registro_usuarios/features/registration/data/repository/registration_repository.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/error/exceptions.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';
import '../../../fixtures/user.dart' as userFixtures;

class MockRegistrationRemoteDataSource extends Mock implements RegistrationRemoteDataSource{}

RegistrationRepositoryImpl repository;
MockRegistrationRemoteDataSource remoteDataSource;

void main(){
  setUp((){
    remoteDataSource = MockRegistrationRemoteDataSource();
    repository = RegistrationRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('register', (){
    User tUser;
    Map<String, dynamic> tJsonUser;
    setUp((){
      tUser = userFixtures.user;
      tJsonUser = userFixtures.jsonUser;
    });
    test('debe llamar los métodos esperados', ()async{
      await repository.register(tUser);
      verify(remoteDataSource.register(UserModel.fromUser(tUser)));
    });

    test('debe retornar el resultado esperado cuando todo sale bien', ()async{
      final result = await repository.register(tUser);
      expect(result, Right(null));
    });

    test('debe retornar el resultado esperado cuando remoteDataSource lanza un error', ()async{
      when(remoteDataSource.register(any)).thenThrow(ServerException());
      final result = await repository.register(tUser);
      expect(result, Left(ServerFailure()));
    });
  });
}