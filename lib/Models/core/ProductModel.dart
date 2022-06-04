class ProductModel {
  String id;
  String name;
  int price;
  String image;
  String type;
  String description;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.type,
      required this.image});

  factory ProductModel.fromMap(Map<String, dynamic> j) {
    return ProductModel(
      id: j['_id'],
      description: j['description'],
      type: j['type'],
      image: j['image'],
      price: j['price'],
      name: j['name'],
    );
  }
}
