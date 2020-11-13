import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pokemon_league/components/nav.dart';
import 'package:pokemon_league/components/com_widgets.dart';
import 'package:pokemon_league/models/objects.dart';
import 'battle_stats.dart';

class HomePage extends StatefulWidget {
  final String uid;
  HomePage({Key key, @required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home Page'),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[_buildContainerOfBattles(context)],
          ),
        ));
  }
}

Widget _buildContainerOfBattles(BuildContext context) {
  final databaseReference = FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
      stream: databaseReference.collection('matches').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildListOfBattles(context, snapshot.data.docs);
      });
}

Widget _buildListOfBattles(
    BuildContext context, List<DocumentSnapshot> snapshot) {
  return Column(
    children:
        snapshot.map((data) => _buildItemsOfBattles(context, data)).toList(),
  );
}

Container _buildItemsOfBattles(BuildContext context, DocumentSnapshot data) {
  final record = Matches.fromSnapshot(data);
  final homeUser = record.homeUser;
  final awayUser = record.awayUser;
  return Container(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
    height: 95,
    width: double.maxFinite,
    child: Card(
      elevation: 5,
      child: InkWell(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BattleStats(homeUser: homeUser, awayUser: awayUser)))
        },
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        userImage(homeUser),
                        userInfo(homeUser, homeUser),
                        Spacer(),
                        userInfo(awayUser, awayUser),
                        userImage(awayUser),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
