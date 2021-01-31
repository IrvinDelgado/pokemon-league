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

  Widget _homeBody(leagueUID) {
    if (leagueUID == '') {
      return new Container(
        child: Center(
          child: Text('No League is Active'),
        ),
      );
    }
    return new FutureBuilder(
      future: getLeagueData(leagueUID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Leagues league = Leagues.fromSnapshot(snapshot.data);
          if (league.creatingMode == 1) return _creatingMode(league);
          return Container(child: Text('In Play'));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  /// In Creation Mode
  /// Invite Button on the Top
  /// List of people in the League
  ///   Pending => Grey
  ///   Accepted => Green

  Widget _creatingMode(Leagues league) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            _showLeagueInfo(league),
            _activateLeague(),
          ],
        ),
      ),
    );
  }

  Widget _showLeagueInfo(Leagues league) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: Container(
        child: Card(
          elevation: 15,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  title: Text('Name of league: ${league.name}'),
                ),
                new ListTile(
                  leading: Icon(Icons.group),
                  title: Text('${league.users.length}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _activateLeague() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: Container(
        child: Card(
          elevation: 15,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.add_circle_outline_outlined),
                  title: Text('Activate League'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
