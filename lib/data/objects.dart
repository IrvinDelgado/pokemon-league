class User {
  final String name;
  final String teamName;
  final String record;
  final List pokemonTeam;
  User(this.name, this.teamName, this.record, this.pokemonTeam);
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
var battleData = {
  'Belgium': ['Belgium', 'Works', '!'],
  'India': ['India', 'Works', '!'],
  'Cambridge': ['Cambridge', 'Works', '!'],
  'Chi-Town': ['Chi-Town', 'Works', '!'],
  'LA': ['LA', 'Works', '!'],
};

final users = <User>[
  User('Irvin', 'LA', '1-1', []),
  User('Marvin', 'Chi-Town', '0-3', []),
  User('Chris', 'Cambridge', '2-1', []),
  User('Gawher', 'India', '2-1', []),
  User('Annibal', 'Belgium', '3-0', []),
  User('Adolfo', 'Vill', '2-1', []),
  User('Chris.JR', 'Seattle', '3-0', []),
  User('Ivan', 'Veracruz', '1-1', []),
  User('Rodney', 'Bellwood', '2-1', []),
  User('Gyoza', 'Las Vegas', '0-2', []),
];

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
