import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pokemon_league/components/api.dart';

class SearchLeague extends StatefulWidget {
  @override
  _SearchLeagueState createState() => _SearchLeagueState();
}

class _SearchLeagueState extends State<SearchLeague> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Searching'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter League Name",
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
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: isLoading
                    ? FutureBuilder(
                        future: requestLeagueNames(nameController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return testList(snapshot);
                          } else {
                            return Container();
                          }
                        })
                    : RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            //Send Query? Show List of Leagues: Error no Leagues
                          }
                        },
                        child: Text('Submit'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView testList(snapshot) {
    //var leagueData = snapshot.data.documents[0].data();
    //var leagueID = snapshot.data.documents[0].id;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Text(snapshot.data.documents[index].data()["name"]),
          subtitle: Text(snapshot.data.documents[index].id),
        );
      },
    );
  }
}
