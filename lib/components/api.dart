import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import 'package:pokemon_league/screens/home.dart';
import 'package:pokemon_league/models/objects.dart';
import 'package:pokemon_league/components/com_widgets.dart';

// Instances
FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// USER AUTH APIS
//////////////////////////////////////////////////////////
// Create User
void createUser(userUID, showDownUserName, context) {
  firestoreInstance.collection("users").doc(userUID).set({
    "losses": 0,
    "pokemonTeam": [],
    "showDownUserName": showDownUserName,
    "teamName": showDownUserName,
    "wins": 0,
    "leaguesIn": [],
    "leaguesCreated": [],
    "leagueActive": "",
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

Future<LeagueUser> getUserData(userUID) async {
  var user = await firestoreInstance.collection("users").doc(userUID).get();
  LeagueUser leagueUser = LeagueUser.fromSnapshot(user);
  return leagueUser;
}

void usersPokemon() {
  firestoreInstance.collection("users").doc('Irvin').get();
}

//////////////////////////////////////////////////////////
// LEAGUE APIS
//////////////////////////////////////////////////////////

void createLeague(leagueName, passcode) {
  firestoreInstance.collection("leagues").add({
    "name": leagueName,
    "passcode": passcode,
    "creator": firebaseAuth.currentUser.uid,
    "creatingMode": 1,
  }).then((value) => addLeagueToUser(value.id, "leaguesCreated"));
}

Future<QuerySnapshot> requestLeagueNames(leagueNameRequested) async {
  var result = await firestoreInstance
      .collection("leagues")
      .where("name", isEqualTo: leagueNameRequested)
      .get();
  return result;
}

Future<DocumentSnapshot> getLeagueData(leagueID) async {
  var leagueData =
      await firestoreInstance.collection("leagues").doc(leagueID).get();
  return leagueData;
}

void makeLeagueActive(String newActiveLeague) {
  firestoreInstance
      .collection("users")
      .doc(firebaseAuth.currentUser.uid)
      .update({
    "leagueActive": newActiveLeague,
  });
}

Future<bool> checkPasswordGiven(passcode, docID) async {
  var result = await firestoreInstance.collection("leagues").doc(docID).get();
  if (result.data()["passcode"] == passcode) {
    addLeagueToUser(docID, "leaguesIn");
    return true;
  }
  return false;
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
          LeagueUser currUser = LeagueUser.fromSnapshot(snapshot.data);
          List listOfLeagueIDS = (leagueType == 'leaguesIn')
              ? currUser.leaguesIn
              : currUser.leaguesCreated;
          return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: listOfLeagueIDS != null ? listOfLeagueIDS.length : 0,
              itemBuilder: (_, int index) {
                //For each league in list create a tile
                return buildFromLeagueID(listOfLeagueIDS[index], context);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  finalTileDivider());
        } else {
          return Container();
        }
      });
}

// Makes a call to Firestore for league data
// docID => league id
FutureBuilder buildFromLeagueID(docID, context) {
  return FutureBuilder(
    future: firestoreInstance.collection('leagues').doc(docID).get(),
    builder: (_, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Leagues league = Leagues.fromMap(snapshot.data.data());
        return leagueTilesforLeaguesIn(
          league.name,
          docID,
          context,
        );
      } else {
        return Container();
      }
    },
  );
}
//////////////////////////////////////////////////////////
//

//Future<Widget> _getUserPhoto() {}
