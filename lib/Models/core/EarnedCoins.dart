import 'dart:convert';

class EarnedCoinsModel {
  String description;
  String type;
  String id;
  DateTime createAt;

  EarnedCoinsModel({
    required this.description,
    required this.id,
    required this.type,
    required this.createAt,
  });

  factory EarnedCoinsModel.fromMap(Map<String, dynamic> j) {
    var map = json.encode(j['awardedBy']);

    if (j['type'] == "Custom") {
      var e = json.decode(map);
      return EarnedCoinsModel(
        id: j['_id'],
        type: j['type'],
        description:
            e['username'] + " awarded you " + j['coin'].toString() + " DGC",
        createAt: DateTime.parse(j['createAt']).add(const Duration(hours: 5)),
      );
    } else {
      return EarnedCoinsModel(
          id: j['_id'],
          type: j['type'],
          description:
              "Earned " + j['coin'].toString() + " DGC for comming in time",
          createAt:
              DateTime.parse(j['createAt']).add(const Duration(hours: 5)));
    }
  }
}
