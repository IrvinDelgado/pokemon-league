import 'package:cloud_firestore/cloud_firestore.dart';

// User
class LeagueUser {
  final String teamName;
  final String showDownUserName;
  final String leagueActive;
  final int wins;
  final int losses;
  final List pokemonTeam;
  final List leaguesIn;
  final List leaguesCreated;
  final DocumentReference reference;

  LeagueUser.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['teamName'] != null),
        assert(map['showDownUserName'] != null),
        assert(map['leagueActive'] != null),
        assert(map['wins'] != null),
        assert(map['losses'] != null),
        assert(map['pokemonTeam'] != null),
        assert(map['leaguesIn'] != null),
        assert(map['leaguesCreated'] != null),
        teamName = map['teamName'],
        showDownUserName = map['showDownUserName'],
        leagueActive = map['showDownUserName'],
        wins = map['wins'],
        losses = map['losses'],
        pokemonTeam = map['pokemonTeam'],
        leaguesIn = map['leaguesIn'],
        leaguesCreated = map['leaguesCreated'];

  LeagueUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "User is <$showDownUserName>";
}

class Matches {
  final String homeUser;
  final String awayUser;
  final DocumentReference reference;

  Matches.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['homeUser'] != null),
        assert(map['awayUser'] != null),
        homeUser = map['homeUser'],
        awayUser = map['awayUser'];

  Matches.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Match is <$homeUser:$awayUser>";
}

class Leagues {
  final String creator;
  final String name;
  final String passcode;
  final DocumentReference reference;

  Leagues.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['creator'] != null),
        assert(map['name'] != null),
        assert(map['passcode'] != null),
        creator = map['creator'],
        name = map['name'],
        passcode = map['passcode'];

  Leagues.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "League created by: named <$creator:$name>";
}
