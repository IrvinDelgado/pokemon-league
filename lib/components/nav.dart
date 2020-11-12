import 'package:flutter/material.dart';
import 'package:pokemon_league/components/api.dart';

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
            leading: Icon(Icons.home_rounded),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Team Viewer'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
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
