import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable{
  final List properties;

  Failure({
    @required this.properties
  });
  
  @override
  List<Object> get props => properties;
}

enum ServerFailureType{
  LOGIN,
  UNHAUTORAIZED,
  NORMAL
}

class ServerFailure extends Failure{
  final String message;
  ServerFailure({
    this.message,
  }): super(
    properties: [message]
  );
}

class InvalidInputFailure extends Failure{}

class FormatFailure extends Failure{}