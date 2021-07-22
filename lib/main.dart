import 'package:flutter/material.dart';
import 'package:registro_usuarios/features/intro/presentation/pages/intro_page.dart';
import 'package:registro_usuarios/dependencies_injection.dart' as dI;
import 'package:registro_usuarios/features/registration/presentation/page/register_page.dart';
 
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
      routes: {
        IntroPage.ROUTE: (_)=>IntroPage(),
        RegisterPage.ROUTE: (_)=>RegisterPage()
      },
      home: IntroPage(),
    );
  }
}