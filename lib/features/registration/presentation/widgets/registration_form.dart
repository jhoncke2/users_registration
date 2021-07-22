import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registro_usuarios/core/presentation/widgets/general_button.dart';
import 'package:registro_usuarios/features/registration/presentation/bloc/registration_bloc.dart';
class RegistrationForm extends StatefulWidget {
  
  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController;
  TextEditingController lastNameController;
  TextEditingController docNumberController;
  TextEditingController emailController;
  TextEditingController phoneController;
  DateTime birthDate;
  File photo;

  @override
  void initState() { 
    super.initState();
    nameController = TextEditingController();    
    lastNameController = TextEditingController();    
    docNumberController = TextEditingController();    
    emailController = TextEditingController();    
    phoneController = TextEditingController(); 
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _createTitle(),
        _createGeneralInput(this.nameController, TextInputType.name, Icons.person, 'Nombre'),
        _createGeneralInput(this.lastNameController, TextInputType.name, Icons.person, 'Apellido'),
        _createGeneralInput(this.docNumberController, TextInputType.number, Icons.card_giftcard, 'Documento identidad'),
        _createGeneralInput(this.emailController, TextInputType.emailAddress, Icons.email, 'Email'),
        _createGeneralInput(this.phoneController, TextInputType.phone, Icons.phone, 'Número telefónico'),
        _createPickImageButton(),
        _createDateButton(),
        _createSendButton()
      ],
    );
  }

  Widget _createTitle(){
    return Text(
      'Registrarse',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _createGeneralInput(TextEditingController controller, TextInputType keyboardType, IconData icon, String label){
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: label,
        isCollapsed: true,
        prefixIcon: Icon(
          icon,
          size: 13,
        ),
        border: _crearInputBorder(),
        enabledBorder: _crearInputBorder()
      ),
    );
  }

  InputBorder _crearInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor.withOpacity(0.525),
        width: 3.5
      )
    );
  }

  Future<void> showAdjuntarFotosDialog(BuildContext context)async{
    await showDialog(
      useRootNavigator: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.0175),
      builder: (BuildContext context){
        return Dialog(
          child: Dialog(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              width: 3
            )
          )
        );
      },
    );
  }

  Widget _createPickImageButton(){
    if(this.photo == null)
      return GeneralButton(text: 'Adjuntar imágen', onPressed: _pickImg);
    else
      return _createInformationText('Imágen adjuntada');
  }

    
  
  Future<void> _pickImg()async{
    try{
      this.photo = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
      });
    }catch(_){

    }
  }

  Widget _createInformationText(String text){
     return Text(
      text,
      style: TextStyle(
        fontSize: 17.5
      ),
    );
  }

  Widget _createDateButton(){
    if(this.birthDate == null)
      return GeneralButton(text: 'Adjuntar fecha de nacimiento', onPressed: _pickBirthDate);
    else
      return _createInformationText(
        'Fecha de nacimiento: ${this.birthDate.year}-${this.birthDate.month}-${this.birthDate.day}'
      );
  }

  Future<void> _pickBirthDate()async{
    this.birthDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2050)
    );
    setState(() {
    });
  }

  Widget _createSendButton(){
    RegistrationState blocState = BlocProvider.of<RegistrationBloc>(context).state;
    if(blocState is OnEmptyRegistration || blocState is OnSuccessfulyRegistrated)
      return GeneralButton(text: 'Enviar', onPressed: (){
        BlocProvider.of<RegistrationBloc>(context).add(RegisterEvent(
          name: this.nameController.text, 
          lastName: this.lastNameController.text,
          docNumber: int.parse( this.docNumberController.text ), 
          email: this.emailController.text, 
          phone: int.parse( this.phoneController.text ), 
          birthDate: this.birthDate, 
          photo: this.photo
        ));
      });
    else
      return CircularProgressIndicator(
        backgroundColor: Colors.blueAccent,
      );
  }
}