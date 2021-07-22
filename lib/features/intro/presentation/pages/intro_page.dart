import 'package:flutter/material.dart';
import 'package:registro_usuarios/core/presentation/widgets/general_button.dart';
import 'package:registro_usuarios/features/registration/presentation/page/register_page.dart';
class IntroPage extends StatefulWidget {
  static const ROUTE = 'intro';
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool terminosYCondicionesAceptados = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Container(
             height: MediaQuery.of(context).size.height * 0.75,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 _createTitle(),
                 _createTerminosCheckBox(),
                 _createContinueButton()
               ],
             ),
           ),
         ),
       ),
    );
  }

  Widget _createTitle(){
    return Text(
      'Página de inicio',
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _createTerminosCheckBox(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: CheckboxListTile(
        title: Text(
          'Acepto términos y condiciones',
          style: TextStyle(
            color: terminosYCondicionesAceptados? Colors.blueAccent: Colors.grey,
            fontSize: 19
          ),
        ), 
        value: terminosYCondicionesAceptados,
        onChanged: (bool isSelected){
           setState((){
             terminosYCondicionesAceptados = isSelected;
          });
        }
      ),
    );
  }

  Widget _createContinueButton(){
    return GeneralButton(
      text: 'Continuar', 
      onPressed: (this.terminosYCondicionesAceptados)?
        _continue 
        : null
    );
  }

  void _continue(){
    Navigator.of(context).pushReplacementNamed(RegisterPage.ROUTE);
  }
}