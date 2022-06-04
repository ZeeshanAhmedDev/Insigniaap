import 'dart:convert';

class DishVoteModel {
  String name;
  String id;
  int vote;
  String image;

  DishVoteModel(
      {required this.name,
      required this.id,
      required this.vote,
      required this.image});

  factory DishVoteModel.fromMap(Map<String, dynamic> j) {
    var map = json.encode(j['dish']);
    var e = json.decode(map);
    return DishVoteModel(
      id: j['_id'],
      vote: j['votes'],
      image: e['image'],
      name: e['name'],
    );
  }
}
