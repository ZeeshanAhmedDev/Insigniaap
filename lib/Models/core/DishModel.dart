class DishModel {
  String id;
  String name;
  String description;
  String image;

  DishModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image});

  factory DishModel.fromMap(Map<String, dynamic> j) {
    return DishModel(
      id: j['_id'],
      description: j['description'],
      image: j['image'],
      name: j['name'],
    );
  }
}
