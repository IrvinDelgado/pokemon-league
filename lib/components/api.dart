import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pokemon_league/screens/home.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// Create User
void createUser(userUID, showDownUserName, context) {
  firestoreInstance.collection("users").doc(userUID).set({
    "losses": 0,
    "pokemonTeam": [],
    "showDownUserName": showDownUserName,
    "teamName": "teamName",
    "wins": 0,
  }).then((res) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(uid: userUID),
        ));
  });
}

Future<void> signOut(context) async {
  await firebaseAuth.signOut().then((value) =>
      Navigator.pushNamedAndRemoveUntil(context, "/signup", (r) => false));
}

// GET list of pokemon of user
void usersPokemon() {
  firestoreInstance
      .collection("users")
      .doc('Irvin')
      .get()
      .then((value) => print(value.data()["pokemonTeam"]));
}
