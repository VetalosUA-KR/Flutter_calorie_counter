import 'open_food_facts_api.dart';
import 'product_model.dart';

class RemoteRepository {
  final OpenFoodFactsApi _api = OpenFoodFactsApi();

  Future<ProductResponse?> fetchProductByBarcode(String barcode) async {
    try {
      final productResponse = await _api.getProductInfo(barcode);
      return productResponse;
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }
}