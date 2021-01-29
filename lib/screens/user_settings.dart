import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_league/components/api.dart';
import 'package:pokemon_league/models/objects.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: _userSettingsBody(context),
    );
  }
}

Widget _userSettingsBody(context) {
  return FutureBuilder(
    future: getUserData(firebaseAuth.currentUser.uid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        LeagueUser user = snapshot.data;
        return _userSettingsInfo(user, context);
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

Widget _userSettingsInfo(LeagueUser user, BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        _userPhoto(user.imageUrl),
        ListTile(
          title: Text(firebaseAuth.currentUser.uid),
          subtitle: Text(
            "User UID",
          ),
          trailing: Icon(Icons.content_copy),
          onTap: () {
            Clipboard.setData(
                new ClipboardData(text: firebaseAuth.currentUser.uid));
            Scaffold.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Copied UID'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {},
              ),
            ));
          },
        ),
        ListTile(
          title: Text(user.teamName),
          subtitle: Text(
            "Team Name",
          ),
          trailing: Icon(Icons.create_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(user.showDownUserName),
          subtitle: Text(
            "Showdown User Name",
          ),
          trailing: Icon(Icons.create_outlined),
          onTap: () {},
        ),
      ],
    ),
  );
}

Widget _userPhoto(String imageUrl) {
  if (imageUrl == "") {
    imageUrl = 'assets/images/userProfiles/LA.jpg';
  }
  return Container(
    height: 150,
    color: Colors.grey,
    child: Center(
      child: Image(
        image: AssetImage(imageUrl),
        height: 125,
        width: 125,
      ),
    ),
  );
}
