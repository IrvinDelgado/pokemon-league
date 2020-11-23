import 'package:flutter/material.dart';

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

Widget finalLeagueTiles(leagueName, leagueUID) {
  return InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {},
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
