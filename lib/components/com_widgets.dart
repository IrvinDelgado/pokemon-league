import 'package:flutter/material.dart';
import 'package:pokemon_league/components/api.dart';
import 'package:pokemon_league/screens/home.dart';
import 'package:pokemon_league/screens/leagues.dart';

Widget userImage(name) {
  return Container(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/images/userProfiles/' + name + '.jpg',
        height: 55,
        width: 85,
      ),
    ),
  );
}

Widget userInfo(name, record) {
  return Container(
    child: RichText(
        text: TextSpan(
            text: name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
            children: <TextSpan>[
          TextSpan(
              text: '\n' + '(' + record + ')',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 12,
              ))
        ])),
  );
}

Future<Widget> subscribeToLeague(leagueName, leagueUID, context) {
  return showDialog(
    context: context,
    builder: (context) {
      final _formKey = GlobalKey<FormState>();
      final TextEditingController passCodeController = TextEditingController();
      return AlertDialog(
        title: Text(leagueName),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: passCodeController,
            decoration: InputDecoration(
              labelText: "Enter PassCode",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Invalid PassCode';
              } else if (value.length > 10) {
                return 'Needs to less than 10 Characters';
              }
              return null;
            },
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close"),
          ),
          FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                bool pass = await checkPasswordGiven(
                    passCodeController.text, leagueUID);
                if (pass) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeagueList()),
                  );
                } else {
                  passCodeController.text = '';
                  _formKey.currentState.validate();
                  return Container();
                }
              }
            },
            child: Text("Submit"),
          ),
        ],
      );
    },
  );
}

Widget finalLeagueTiles(leagueName, leagueUID, context) {
  return InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {
      return subscribeToLeague(leagueName, leagueUID, context);
    },
    child: ListTile(
      title: Text(leagueName),
      subtitle: Text(
        "uid: " + leagueUID,
      ),
      trailing: Icon(Icons.arrow_forward),
    ),
  );
}

Widget leagueTilesforLeaguesIn(leagueName, leagueUID, context) {
  return InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(uid: leagueUID)),
    ),
    child: ListTile(
      title: Text(leagueName),
      subtitle: Text(
        "uid: " + leagueUID,
      ),
      trailing: Icon(Icons.arrow_forward),
    ),
  );
}

Divider finalTileDivider() {
  return Divider(
    color: Colors.grey,
    height: 10,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}
