import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pokemon_league/screens/home.dart';
import 'package:pokemon_league/models/objects.dart';
import 'package:pokemon_league/components/com_widgets.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// USER AUTH APIS

// Create User
void createUser(userUID, showDownUserName, context) {
  firestoreInstance.collection("users").doc(userUID).set({
    "losses": 0,
    "pokemonTeam": [],
    "showDownUserName": showDownUserName,
    "teamName": "teamName",
    "wins": 0,
    "leaguesIn": [],
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

void usersPokemon() {
  firestoreInstance.collection("users").doc('Irvin').get();
}

void getUserData() {
  firestoreInstance
      .collection("users")
      .doc(firebaseAuth.currentUser.uid)
      .snapshots();
}

// League APIS

void createLeague(leagueName, passcode) {
  firestoreInstance.collection("leagues").add({
    "name": leagueName,
    "passcode": passcode,
    "creator": firebaseAuth.currentUser.uid,
  }).then((value) => addLeagueToUser(value.id, "leaguesCreated"));
}

void addLeagueToUser(leagueUID, leagueType) {
  firestoreInstance
      .collection("users")
      .doc(firebaseAuth.currentUser.uid)
      .update({
    leagueType: FieldValue.arrayUnion([leagueUID]),
  });
}

Widget showLeaguesIn(BuildContext context, String leagueType) {
  return StreamBuilder<DocumentSnapshot>(
      stream: firestoreInstance
          .collection("users")
          .doc(firebaseAuth.currentUser.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // get course document
          var courseDocument = snapshot.data.data();
          // get sections from the document
          var sections = courseDocument[leagueType];
          // build list
          return leagueTiles(sections);
        } else {
          return Container();
        }
      });
}

FutureBuilder leagueTilesUpdated(docID) {
  return FutureBuilder(
    future: firestoreInstance.collection('leagues').doc(docID).get(),
    builder: (_, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Leagues league = Leagues.fromMap(snapshot.data.data());
        return finalLeagueTiles(league.name, docID);
      } else {
        return Container();
      }
    },
  );
}

ListView leagueTiles(listOfLeagueIDS) {
  return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listOfLeagueIDS != null ? listOfLeagueIDS.length : 0,
      itemBuilder: (_, int index) {
        return leagueTilesUpdated(listOfLeagueIDS[index]);
      },
      separatorBuilder: (BuildContext context, int index) =>
          finalTileDivider());
}

Future<QuerySnapshot> requestLeagueNames(leagueNameRequested) async {
  var result = await firestoreInstance
      .collection("leagues")
      .where("name", isEqualTo: leagueNameRequested)
      .get();
  return result;
}
