import 'package:registro_usuarios/features/registration/domain/entities/user.dart';

class UserModel extends User{
  UserModel.fromUser(
    User user
  ):super(
    name: user.name,
    lastName: user.lastName,
    docNumber: user.docNumber,
    email: user.email,
    phone: user.phone,
    birthDate: user.birthDate,
    photo: user.photo
  );

  String _getBirthDateToString() => '${this.birthDate.year}-${this.birthDate.month}-${this.birthDate.day}';

  Map<String, String> toServiceJson() => {
    'name': this.name,
    'lastName': this.lastName,
    'docNumber': this.docNumber.toString(),
    'email': this.email,
    'phone': this.phone.toString(),
    'birthDate': _getBirthDateToString(),
  };
}