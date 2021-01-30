import 'package:flutter/material.dart';

import 'package:pokemon_league/components/api.dart';
import 'package:pokemon_league/screens/league_invites.dart';
import 'package:pokemon_league/screens/leagues.dart';
import 'package:pokemon_league/screens/user_settings.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/themes/pokeball.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text('Leagues'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeagueList()))
            },
          ),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text('Invites'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeagueInvites()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSettings()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () async {
              await signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
