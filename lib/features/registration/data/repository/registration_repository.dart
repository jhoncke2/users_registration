import 'package:meta/meta.dart';
import 'package:registro_usuarios/features/registration/data/data_sources/registration_remote_data_source.dart';
import 'package:registro_usuarios/features/registration/data/models/user_model.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:registro_usuarios/features/registration/domain/repository/registration_repository.dart';
import 'package:registro_usuarios/features/registration/error/exceptions.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';

class RegistrationRepositoryImpl implements RegistrationRepository{
  final RegistrationRemoteDataSource remoteDataSource;
  RegistrationRepositoryImpl({
    @required this.remoteDataSource
  });
  @override
  Future<Either<Failure, void>> register(User user)async{
    try{
      UserModel userModel = UserModel.fromUser(user);
      await remoteDataSource.register(userModel);
      return Right(null);
    }on ServerException{
      return Left(ServerFailure());
    }
  }
  
}