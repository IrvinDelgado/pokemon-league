import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String teamName;
  final String showDownUserName;
  final int wins;
  final int losses;
  final List pokemonTeam;
  User(this.teamName, this.showDownUserName, this.wins, this.losses,
      this.pokemonTeam);
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
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Match is <$homeUser:$awayUser>";
}

/*
class Battle {
  final String homeUser;
  final List battleLinks; //2-3 battle links since best of 3

  Battle(this.homeUser, this.battleLinks);

  Battle.fromJson(Map<String, dynamic> json)
      : homeUser = json['homeUser'],
        battleLinks = json['battleLinks'];

  Map<String, dynamic> toJson() => {
        'homeUser': homeUser,
        'battleLinks': battleLinks,
      };
}
*/
/*
List makeBattlePairs(totalUsers, weekNum) {
  List battlePairs = [];
  //Check if amount of users are even
  if (totalUsers.length % 2 != 0) {
    totalUsers.add(User('N/A', 'N/A', 'N/A', []));
  }
  while (weekNum != 0) {
    User temp;
    User temp2;
    for (var i = 1; i < totalUsers.length; i++) {
      if (i == 1) {
        temp = totalUsers[1];
        totalUsers[1] = totalUsers[totalUsers.length - 1];
      }
      temp2 = totalUsers[i];
      totalUsers[i] = temp;
      temp = temp2;
    }
    weekNum--;
  }

  int firstInPairIndex = totalUsers.length ~/ 2 - 1;
  int secondInPairIndex = firstInPairIndex + 1;
  for (; firstInPairIndex >= 0; firstInPairIndex--) {
    battlePairs
        .add([totalUsers[firstInPairIndex], totalUsers[secondInPairIndex]]);
    secondInPairIndex += 1;
  }
  return battlePairs;
}
*/
