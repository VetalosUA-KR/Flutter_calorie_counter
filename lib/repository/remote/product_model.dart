import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    @JsonKey(name: 'product') Product? product,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'brands') String? brands,
    @JsonKey(name: 'ingredients_text') String? ingredientsText,
    @JsonKey(name: 'nutriments') Nutriments? nutriments,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class Nutriments with _$Nutriments {
  const factory Nutriments({
    @JsonKey(name: 'energy-kcal') double? energyKcal,
    @JsonKey(name: 'proteins') double? proteins,
    @JsonKey(name: 'fat') double? fat,
    @JsonKey(name: 'carbohydrates') double? carbohydrates,
  }) = _Nutriments;

  factory Nutriments.fromJson(Map<String, dynamic> json) =>
      _$NutrimentsFromJson(json);
}