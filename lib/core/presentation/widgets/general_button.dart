import 'package:flutter/material.dart';
class GeneralButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const GeneralButton({
    @required this.text,
    @required this.onPressed,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blueAccent,
      shape: _createBtnShape(),
      child: _createButtonText(),    
      onPressed: this.onPressed
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

  Widget _createButtonText(){
    return Text(
      this.text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.5
      ),
    );
  }
}