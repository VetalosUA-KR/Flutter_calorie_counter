import 'package:dio/dio.dart';
import 'product_model.dart';
import 'dio_client.dart';

class OpenFoodFactsApi {
  final Dio _dio = DioClient().dio;

  Future<ProductResponse> getProductInfo(String barcode) async {
    try {
      final response = await _dio.get(
        'api/v0/product/$barcode.json',
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product info: $e');
    }
  }
}