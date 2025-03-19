import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_model.dart';
part 'search_response.freezed.dart'; // Добавляем директиву для freezed
part 'search_response.g.dart'; // Добавляем директиву для json_serializable

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    @JsonKey(name: 'count') int? count,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'page_size') int? pageSize,
    @JsonKey(name: 'products') List<Product>? products,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}