import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String name;
  final String lastName;
  final int docNumber;
  final String email;
  final int phone;
  final DateTime birthDate;
  final File photo;
  User({
    this.name, 
    this.lastName, 
    this.docNumber, 
    this.email, 
    this.phone, 
    this.birthDate, 
    this.photo
  });
  @override
  List<Object> get props => [
    this.name, 
    this.lastName, 
    this.docNumber, 
    this.email, 
    this.phone, 
    this.birthDate, 
    this.photo
  ];
}
