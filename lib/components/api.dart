import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pokemon_league/screens/home.dart';

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
  firestoreInstance
      .collection("users")
      .doc('Irvin')
      .get()
      .then((value) => print(value.data()["pokemonTeam"]));
}

void getUserData() {
  firestoreInstance
      .collection("users")
      .doc(firebaseAuth.currentUser.uid)
      .snapshots()
      .listen((value) {
    print(value.data());
  });
}

// League APIS

void createLeague(leagueName, passcode) {
  firestoreInstance.collection("leagues").add({
    "name": leagueName,
    "passcode": passcode,
    "creator": firebaseAuth.currentUser.uid,
  }).then((value) => addLeagueToUser(value.id, leagueName, "leaguesCreated"));
}

void addLeagueToUser(leagueUID, teamName, leagueType) {
  firestoreInstance
      .collection("users")
      .doc(firebaseAuth.currentUser.uid)
      .update({
    leagueType: FieldValue.arrayUnion([leagueUID + ',' + teamName]),
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

ListView leagueTiles(sections) {
  return ListView.separated(
    itemCount: sections != null ? sections.length : 0,
    itemBuilder: (_, int index) {
      List leagueData = sections[index].split(",");
      print(leagueData);
      return InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: ListTile(
          title: Text(leagueData[1]),
          subtitle: Text(
            "uid: " + leagueData[0],
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(
      color: Colors.grey,
      height: 10,
      thickness: 1,
      indent: 50,
      endIndent: 50,
    ),
  );
}
