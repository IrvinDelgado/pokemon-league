import 'package:flutter/material.dart';
import 'package:pokemon_league/components/api.dart';

import 'package:pokemon_league/components/nav.dart';
import 'package:pokemon_league/models/objects.dart';

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
      body: _homeBody(this.widget.uid),
    );
  }
}

Widget _homeBody(leagueUID) {
  return new FutureBuilder(
    future: getLeagueData(leagueUID),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Leagues league = Leagues.fromSnapshot(snapshot.data);
        if (league.creatingMode == 1) {
          return _creatingMode();
        }
        return Container(child: Text('In Play'));
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

Widget _creatingMode() {
  return Center(
    child: Text('CREATING'),
  );
}
