import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_league/screens/leagues.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:pokemon_league/components/api.dart';
import 'package:pokemon_league/models/objects.dart';
import 'package:pokemon_league/screens/home.dart';

//import 'home.dart';
import 'signup_login.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  User result = FirebaseAuth.instance.currentUser;
  Future<Widget> loadFromFuture() async {
    if (result != null) {
      LeagueUser user = await getUserData(result.uid);
      if (user.leagueActive == '') {
        return Future.value(LeagueList());
      }
      return Future.value(HomePage(uid: user.leagueActive));
    } else {
      return Future.value(SignUp());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      routeName: "/",
      navigateAfterFuture: loadFromFuture(),
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
