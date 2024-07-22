class Category {
  final int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
