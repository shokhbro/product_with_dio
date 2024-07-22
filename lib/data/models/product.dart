import 'category.dart';

class Product {
  final int id;
  String title;
  int price;
  String description;
  Category category;
  List images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'] as String? ?? 'title none',
      price: map['price'] is int ? map['price'] : int.parse(map['price']),
      description: map['description'] ?? 'description none',
      images: List<String>.from(map['images'] ?? []),
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'tile': title});
    result.addAll({'price': price});
    result.addAll({'description': description});
    result.addAll({'images': images});
    result.addAll({'category': category.toMap()});
    return result;
  }
}
