import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:pokemon_league/models/objects.dart';

final firestoreInstance = Firestore.instance;

// Create User
void createUser() {
  firestoreInstance.collection("users").add({
    "losses": 0,
    "pokemonTeam": ["Pikachu"],
    "showDownUserName": "Something",
    "teamName": "teamName",
    "wins": 0,
  });
}

// GET list of pokemon of user
void usersPokemon() {
  firestoreInstance
      .collection("users")
      .document('Irvin')
      .get()
      .then((value) => print(value.data["pokemonTeam"]));
}
