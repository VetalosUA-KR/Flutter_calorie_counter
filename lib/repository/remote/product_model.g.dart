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
    );

Map<String, dynamic> _$$ProductResponseImplToJson(
        _$ProductResponseImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      productName: json['product_name'] as String?,
      brands: json['brands'] as String?,
      ingredientsText: json['ingredients_text'] as String?,
      nutriments: json['nutriments'] == null
          ? null
          : Nutriments.fromJson(json['nutriments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'brands': instance.brands,
      'ingredients_text': instance.ingredientsText,
      'nutriments': instance.nutriments,
    };

_$NutrimentsImpl _$$NutrimentsImplFromJson(Map<String, dynamic> json) =>
    _$NutrimentsImpl(
      energyKcal: (json['energy-kcal'] as num?)?.toDouble(),
      proteins: (json['proteins'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NutrimentsImplToJson(_$NutrimentsImpl instance) =>
    <String, dynamic>{
      'energy-kcal': instance.energyKcal,
      'proteins': instance.proteins,
      'fat': instance.fat,
      'carbohydrates': instance.carbohydrates,
    };
