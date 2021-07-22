import 'package:flutter/material.dart';
import 'package:registro_usuarios/features/registration/presentation/page/register_page.dart';
 
void main() => runApp(MyApp());
 
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