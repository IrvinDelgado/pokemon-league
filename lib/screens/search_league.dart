import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pokemon_league/components/api.dart';
import 'package:pokemon_league/components/com_widgets.dart';
import 'package:pokemon_league/models/objects.dart';

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
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: isLoading
                    ? FutureBuilder(
                        future: requestLeagueNames(nameController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data.docs.length != 0) {
                            return leaguesFound(snapshot);
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data.docs.length == 0) {
                            return Text("Nothing Found...");
                          } else {
                            return Container();
                          }
                        })
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView leaguesFound(snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.docs.length,
      itemBuilder: (_, int index) {
        Leagues league = Leagues.fromSnapshot(snapshot.data.docs[index]);
        return finalLeagueTiles(
          league.name,
          league.reference.id,
          context,
        );
      },
      separatorBuilder: (context, index) => finalTileDivider(),
    );
  }
}
