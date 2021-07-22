import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
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
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.125),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _createGeneralInput(widget.nameController, TextInputType.name, Icons.person, 'Nombre'),
                _createGeneralInput(widget.nameController, TextInputType.name, Icons.person, 'Apellido'),
                _createGeneralInput(widget.nameController, TextInputType.number, Icons.card_giftcard, 'Documento identidad'),
                _createGeneralInput(widget.nameController, TextInputType.emailAddress, Icons.email, 'Email'),
                _createGeneralInput(widget.nameController, TextInputType.phone, Icons.phone, 'Número telefónico'),
                _createPickImageButton()
              ],
            ),
          ),
        ),
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
    return MaterialButton(
      color: Colors.blueAccent,
      shape: _createBtnShape(),
      child: _createButtonText('Adjuntar foto'),    
      onPressed: _pickImg
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
    }catch(_){

    }

  }
  
}