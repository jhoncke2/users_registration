import 'package:dartz/dartz.dart';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';

abstract class RegistrationRepository{
  Future<Either<Failure, void>> register(User user);
}