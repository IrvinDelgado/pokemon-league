import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pokemon_league/pages/home.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
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
  }).catchError((err) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(err.message),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
}

// GET list of pokemon of user
void usersPokemon() {
  firestoreInstance
      .collection("users")
      .doc('Irvin')
      .get()
      .then((value) => print(value.data()["pokemonTeam"]));
}
