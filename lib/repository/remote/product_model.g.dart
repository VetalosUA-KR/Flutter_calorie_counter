// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductResponseImpl _$$ProductResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductResponseImpl(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      statusVerbose: json['status_verbose'] as String?,
    );

Map<String, dynamic> _$$ProductResponseImplToJson(
        _$ProductResponseImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
      'status': instance.status,
      'status_verbose': instance.statusVerbose,
    };

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      productName: json['product_name'] as String?,
      brands: json['brands'] as String?,
      ingredientsText: json['ingredients_text'] as String?,
      nutriments: json['nutriments'] == null
          ? null
          : Nutriments.fromJson(json['nutriments'] as Map<String, dynamic>),
      nutritionGrades: json['nutrition_grades'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'brands': instance.brands,
      'ingredients_text': instance.ingredientsText,
      'nutriments': instance.nutriments,
      'nutrition_grades': instance.nutritionGrades,
      'image_url': instance.imageUrl,
    };

_$NutrimentsImpl _$$NutrimentsImplFromJson(Map<String, dynamic> json) =>
    _$NutrimentsImpl(
      energyKcal: (json['energy-kcal_100g'] as num?)?.toDouble(),
      proteins: (json['proteins_100g'] as num?)?.toDouble(),
      fat: (json['fat_100g'] as num?)?.toDouble(),
      carbohydrates: (json['carbohydrates_100g'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NutrimentsImplToJson(_$NutrimentsImpl instance) =>
    <String, dynamic>{
      'energy-kcal_100g': instance.energyKcal,
      'proteins_100g': instance.proteins,
      'fat_100g': instance.fat,
      'carbohydrates_100g': instance.carbohydrates,
    };
