import 'package:dio/dio.dart';
import 'package:product_with_dio/data/models/product.dart';

class DioClient {
  final _dio = Dio();

  DioClient._private() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..responseType = ResponseType.json
      ..baseUrl = "https://api.escuelajs.co/api/v1";
  }

  static final _singletonConstructor = DioClient._private();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParms,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParms);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    required Product product,
  }) async {
    try {
      final data = product.toMap();
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      print('Error in Post request: $e');
      rethrow;
    }
  }

  Future<Response> put({
    required String url,
    required Product product,
  }) async {
    try {
      final data = product.toMap();
      final response = await _dio.put(url, queryParameters: data);
      return response;
    } catch (e) {
      print('Error in Put request: $e');
      rethrow;
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } catch (e) {
      print('Error in Delete request: $e');
      rethrow;
    }
  }

  Future<void> download(String url, String saveDirectory) async {
    await _dio.download(
      url,
      saveDirectory,
      onReceiveProgress: (count, total) {
        print("${(count / total * 100).toStringAsFixed(0)}%");
      },
    );
  }
}
