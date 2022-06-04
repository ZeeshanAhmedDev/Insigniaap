import 'dart:convert';

class RedeemCoinModel {
  String id;
  String image;
  String name;
  String status;
  int price;
  DateTime createAt;

  RedeemCoinModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.status,
      required this.createAt});

  factory RedeemCoinModel.fromMap(Map<String, dynamic> j) {
    var map = json.encode(j['productId']);
    var e = json.decode(map);
    return RedeemCoinModel(
      id: j['_id'],
      status: j['status'],
      image: e['image'],
      price: e['price'],
      name: e['name'],
      createAt: DateTime.parse(j['createAt']).add(const Duration(hours: 5)),
    );
  }
}
