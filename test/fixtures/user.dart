import 'dart:io';
import 'package:registro_usuarios/features/registration/domain/entities/user.dart';

final jsonUser = {
  'name': 'User1',  
  'lastName': 'User1tegui',
  'docNumber': 123456789,
  'email': 'user1@email.com',
  'phone': 1234567890,
  'birthDate': '1997-3-25'
};

final user = User(
  name: 'User1',  
  lastName: 'User1tegui',
  docNumber: 123456789,
  email: 'user1@email.com',
  phone: 1234567890,
  birthDate: DateTime(1997, 3, 25),
  photo: File('./test_img.jpg'),  
);