// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visit_saltus/screens/registration_screens/Logo_Screen.dart';

void main() {
  //}async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Logo(),
    );
  }
}
