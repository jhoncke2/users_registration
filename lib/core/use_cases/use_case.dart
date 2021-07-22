import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:registro_usuarios/features/registration/error/failures.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable{
  @override
  List<Object> get props => [this.runtimeType];
}