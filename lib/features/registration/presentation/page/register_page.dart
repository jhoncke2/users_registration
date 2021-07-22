import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registro_usuarios/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:registro_usuarios/features/registration/presentation/widgets/registration_form.dart';
import '../../../../dependencies_injection.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  static const ROUTE = 'register';
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController;
  TextEditingController lastNameController;
  TextEditingController docNumberController;
  TextEditingController emailController;
  TextEditingController phoneController;

  RegisterPage({Key key}) : super(key: key){
    nameController = TextEditingController();    
    lastNameController = TextEditingController();    
    docNumberController = TextEditingController();    
    emailController = TextEditingController();    
    phoneController = TextEditingController();     
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime birthDate;
  File photo;
  RegistrationState blocState;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegistrationBloc>(
        create: (_)=>sl(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.925,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.125),
            child: Center(
              child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (blocContext, state){
                  this.context = blocContext;
                  this.blocState = state;
                  if(state is OnSuccessfulyRegistrated)
                    return _createSuccessfulyRegistratedText();
                  else if(state is OnRegistrationError){
                    _resetForm();
                    return _createMessageWidget(state.message, Colors.redAccent, Colors.white);
                  }
                  else
                    return RegistrationForm();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createSuccessfulyRegistratedText(){
    return _createMessageWidget(
      'El usuario ha sido registrado',
      Colors.greenAccent,
      Colors.black
    );
  }

  void _resetForm(){
    widget.nameController.text = null;
    widget.lastNameController.text = null;
    widget.docNumberController.text = null;
    widget.emailController.text = null;
    widget.phoneController.text = null;
    this.photo = null;
    birthDate = null;
  }

  Widget _createMessageWidget(String message, Color backgroundColor, Color textColor){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 30
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor
        ),
      ),
    );
  }

  Widget _createFormComponents(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _createTitle(),
        _createGeneralInput(widget.nameController, TextInputType.name, Icons.person, 'Nombre'),
        _createGeneralInput(widget.lastNameController, TextInputType.name, Icons.person, 'Apellido'),
        _createGeneralInput(widget.docNumberController, TextInputType.number, Icons.card_giftcard, 'Documento identidad'),
        _createGeneralInput(widget.emailController, TextInputType.emailAddress, Icons.email, 'Email'),
        _createGeneralInput(widget.phoneController, TextInputType.phone, Icons.phone, 'Número telefónico'),
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
      return _createButton('Adjuntar imágen', _pickImg);
    else
      return _createInformationText('Imágen adjuntada');
  }

  Widget _createButton(String text, Function onPressed){
    return MaterialButton(
      color: Colors.blueAccent,
      shape: _createBtnShape(),
      child: _createButtonText(text),    
      onPressed: onPressed
    );
  }

  ShapeBorder _createBtnShape(){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        15
      ),
      side: BorderSide(
        color: Colors.black26
      )
    );
  }

  Widget _createButtonText(String text){
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.5
      ),
    );
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
      return _createButton('Adjuntar fecha de nacimiento', _pickBirthDate);
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
    if(blocState is OnEmptyRegistration || blocState is OnSuccessfulyRegistrated)
      return _createButton('Enviar', (){
        BlocProvider.of<RegistrationBloc>(context).add(RegisterEvent(
          name: widget.nameController.text, 
          lastName: widget.lastNameController.text,
          docNumber: int.parse( widget.docNumberController.text ), 
          email: widget.emailController.text, 
          phone: int.parse( widget.phoneController.text ), 
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