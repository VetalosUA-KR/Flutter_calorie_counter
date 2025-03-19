import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    @JsonKey(name: 'product') Product? product,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'status_verbose') String? statusVerbose,
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
    @JsonKey(name: 'nutrition_grades') String? nutritionGrades,
    @JsonKey(name: 'image_url') String? imageUrl, // Добавляем поле для изображения
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class Nutriments with _$Nutriments {
  const factory Nutriments({
    @JsonKey(name: 'energy-kcal_100g') double? energyKcal,
    @JsonKey(name: 'proteins_100g') double? proteins,
    @JsonKey(name: 'fat_100g') double? fat,
    @JsonKey(name: 'carbohydrates_100g') double? carbohydrates,
  }) = _Nutriments;

  factory Nutriments.fromJson(Map<String, dynamic> json) =>
      _$NutrimentsFromJson(json);
}