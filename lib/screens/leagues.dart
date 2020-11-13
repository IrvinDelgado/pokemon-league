import 'package:flutter/material.dart';

import 'package:pokemon_league/components/api.dart';

class LeagueList extends StatefulWidget {
  @override
  _LeagueListState createState() => _LeagueListState();
}

class _LeagueListState extends State<LeagueList> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("League"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                child: Card(
                  elevation: 15,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      _createLeagueDialogue(context, _formKey);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.add_circle_outline_outlined),
                          title: Text('Create a League'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future _createLeagueDialogue(context, _formKey) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passCodeController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("League Creation"),
        clipBehavior: Clip.none,
        scrollable: true,
        content: new Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Enter User Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter League Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
                          return 'Enter PassCode';
                        } else if (value.length > 10) {
                          return 'Needs to less than 10 Characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: RaisedButton(
              color: Colors.lightBlue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  createLeague(nameController.text, passCodeController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      );
    },
  );
}
