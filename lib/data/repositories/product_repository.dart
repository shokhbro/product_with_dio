import 'package:product_with_dio/data/models/product.dart';
import 'package:product_with_dio/data/services/dio_product_service.dart';

class ProductRepository {
  final DioProductService _dioProductService;
  ProductRepository({required DioProductService dioProductService})
      : _dioProductService = dioProductService;

  Future<List<Product>> getProduct() async {
    return await _dioProductService.getProduct();
  }

  Future<void> addProduct(Product product) async {
    return await _dioProductService.addProduct(product);
  }

  Future<void> updateProduct(int id, Product product) async {
    return await _dioProductService.updateProdut(id, product);
  }

  Future<void> deleteProduct(int productId) async {
    return await _dioProductService.deleteProduct(productId);
  }
}
