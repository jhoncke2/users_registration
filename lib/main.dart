import 'package:flutter/material.dart';
import 'package:registro_usuarios/features/registration/presentation/page/register_page.dart';
import 'package:registro_usuarios/dependencies_injection.dart' as dI;
 
void main(){
  dI.init();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: RegisterPage(),
    );
  }
}