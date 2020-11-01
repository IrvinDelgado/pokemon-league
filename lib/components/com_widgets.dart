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
