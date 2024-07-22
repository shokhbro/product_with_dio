import 'package:product_with_dio/core/network/dio_client.dart';
import 'package:product_with_dio/data/models/product.dart';

class DioProductService {
  final _dioClient = DioClient();

  Future<List<Product>> getProduct() async {
    try {
      final response = await _dioClient.get(url: "/products");

      List<Product> products = [];

      for (var product in response.data) {
        products.add(Product.fromMap(product));
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final resonse = await _dioClient.post(
        url: '/products',
        product: product,
      );
      print("product addd: ${resonse.data}");
    } catch (e) {
      print("Error adding product: $e");
      rethrow;
    }
  }

  Future<void> updateProdut(int id, Product product) async {
    try {
      final response = await _dioClient.put(
        url: '/products/$id',
        product: product,
      );
      print("Product updated: ${response.data}");
    } catch (e) {
      print("Error product updated: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dioClient.delete(
        url: "/products/$id",
      );
      print("Product deleted: ${response.data}");
    } catch (e) {
      print("Error deleted product: ${e.toString()}");
    }
  }
}
