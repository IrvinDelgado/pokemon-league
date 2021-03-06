import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokemon_league/screens/intro_screen.dart';
import 'package:pokemon_league/screens/signup_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon League',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: IntroScreen(),
      routes: {
        '/signup': (context) => SignUp(),
      },
    );
  }
}
