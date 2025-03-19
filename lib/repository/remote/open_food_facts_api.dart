import 'package:dio/dio.dart';
import 'package:flutterhelloworld/repository/remote/search_response.dart';
import 'product_model.dart';
import 'dio_client.dart';

class OpenFoodFactsApi {
  final Dio _dio = DioClient().dio;

  Future<ProductResponse> getProductInfo(String barcode) async {
    try {
      final response = await _dio.get(
        'api/v2/product/$barcode',
        queryParameters: {
          'fields': 'product_name,nutriments,nutrition_grades,ingredients_text',
        },
      );

      // Проверяем статус ответа
      if (response.data['status'] == 1) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw Exception('Product not found: ${response.data['status_verbose']}');
      }
    } catch (e) {
      throw Exception('Failed to fetch product info: $e');
    }
  }

  // Дополнительный метод для поиска продуктов (опционально)
  Future<SearchResponse> searchProducts({
    String? query,
    int page = 1,
    int pageSize = 20,
    bool sortAlphabetically = false,
  }) async {
    try {
      final queryParams = {
        if (query != null && query.isNotEmpty) 'search_terms': query,
        'page': page,
        'page_size': pageSize,
        if (sortAlphabetically) 'sort_by': 'product_name',
        'fields': 'product_name,brands,ingredients_text,nutriments,nutrition_grades,image_url',
      };
      print('Sending request with query params: $queryParams'); // Отладочный лог
      final response = await _dio.get(
        'api/v2/search',
        queryParameters: queryParams,
      );

      print('Response data: ${response.data}'); // Отладочный лог
      return SearchResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

}