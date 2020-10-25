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

class BattleStats extends StatelessWidget {
  final String homeUser;
  final String awayUser;
  BattleStats({Key key, @required this.homeUser, this.awayUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(homeUser + ' Vs. ' + awayUser),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 160,
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Card(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return RaisedButton(
                          //Actual Link is battleData[homeUser.teamName][index]
                          onPressed: null,
                          child: Text('Battle ' + index.toString()),
                        );
                      },
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        homeUser,
                        style: userTextStyle(),
                      ),
                      Spacer(),
                      Text(
                        awayUser,
                        style: userTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      userImage(homeUser),
                      Spacer(),
                      userImage(awayUser)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle userTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20,
  );
}
/*
Battle Links
  Key is Home User in the future
Battle Stats
  MVP
  LIST of Pokemon?
*/
