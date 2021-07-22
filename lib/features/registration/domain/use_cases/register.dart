import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:registro_usuarios/core/use_cases/use_case.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/domain/repository/registration_repository.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';

class Register implements UseCase<void, RegisterParams>{
  final RegistrationRepository repository;
  Register({
    @required this.repository
  });
  @override
  Future<Either<Failure, void>> call(RegisterParams params)async{
    return await repository.register(params.user);
  }
}

class RegisterParams extends Equatable{
  final User user;
  RegisterParams({
    @required this.user 
  });
  @override
  List<Object> get props => [this.user];
}