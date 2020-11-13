import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:pokemon_league/pages/home.dart';
import 'package:pokemon_league/pages/sign_up.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
      routeName: "/",
      navigateAfterSeconds:
          result != null ? HomePage(uid: result.uid) : SignUp(),
      seconds: 5,
      title: new Text(
        'Pokemon Draft League App!',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset('assets/images/themes/pokeball_splash.jpg',
          fit: BoxFit.scaleDown),
      photoSize: 100.0,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      onClick: () => print('it has been clicked!'),
      loaderColor: Colors.red,
    );
  }
}
