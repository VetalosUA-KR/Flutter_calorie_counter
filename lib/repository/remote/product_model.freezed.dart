// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return _ProductResponse.fromJson(json);
}

/// @nodoc
mixin _$ProductResponse {
  @JsonKey(name: 'product')
  Product? get product => throw _privateConstructorUsedError;

  /// Serializes this ProductResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductResponseCopyWith<ProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductResponseCopyWith<$Res> {
  factory $ProductResponseCopyWith(
          ProductResponse value, $Res Function(ProductResponse) then) =
      _$ProductResponseCopyWithImpl<$Res, ProductResponse>;
  @useResult
  $Res call({@JsonKey(name: 'product') Product? product});

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductResponseCopyWithImpl<$Res, $Val extends ProductResponse>
    implements $ProductResponseCopyWith<$Res> {
  _$ProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ) as $Val);
  }

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductResponseImplCopyWith<$Res>
    implements $ProductResponseCopyWith<$Res> {
  factory _$$ProductResponseImplCopyWith(_$ProductResponseImpl value,
          $Res Function(_$ProductResponseImpl) then) =
      __$$ProductResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'product') Product? product});

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ProductResponseImplCopyWithImpl<$Res>
    extends _$ProductResponseCopyWithImpl<$Res, _$ProductResponseImpl>
    implements _$$ProductResponseImplCopyWith<$Res> {
  __$$ProductResponseImplCopyWithImpl(
      _$ProductResponseImpl _value, $Res Function(_$ProductResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_$ProductResponseImpl(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductResponseImpl implements _ProductResponse {
  const _$ProductResponseImpl({@JsonKey(name: 'product') this.product});

  factory _$ProductResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductResponseImplFromJson(json);

  @override
  @JsonKey(name: 'product')
  final Product? product;

  @override
  String toString() {
    return 'ProductResponse(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductResponseImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductResponseImplCopyWith<_$ProductResponseImpl> get copyWith =>
      __$$ProductResponseImplCopyWithImpl<_$ProductResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductResponseImplToJson(
      this,
    );
  }
}

abstract class _ProductResponse implements ProductResponse {
  const factory _ProductResponse(
          {@JsonKey(name: 'product') final Product? product}) =
      _$ProductResponseImpl;

  factory _ProductResponse.fromJson(Map<String, dynamic> json) =
      _$ProductResponseImpl.fromJson;

  @override
  @JsonKey(name: 'product')
  Product? get product;

  /// Create a copy of ProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductResponseImplCopyWith<_$ProductResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brands')
  String? get brands => throw _privateConstructorUsedError;
  @JsonKey(name: 'ingredients_text')
  String? get ingredientsText => throw _privateConstructorUsedError;
  @JsonKey(name: 'nutriments')
  Nutriments? get nutriments => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'brands') String? brands,
      @JsonKey(name: 'ingredients_text') String? ingredientsText,
      @JsonKey(name: 'nutriments') Nutriments? nutriments});

  $NutrimentsCopyWith<$Res>? get nutriments;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? brands = freezed,
    Object? ingredientsText = freezed,
    Object? nutriments = freezed,
  }) {
    return _then(_value.copyWith(
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      brands: freezed == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredientsText: freezed == ingredientsText
          ? _value.ingredientsText
          : ingredientsText // ignore: cast_nullable_to_non_nullable
              as String?,
      nutriments: freezed == nutriments
          ? _value.nutriments
          : nutriments // ignore: cast_nullable_to_non_nullable
              as Nutriments?,
    ) as $Val);
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutrimentsCopyWith<$Res>? get nutriments {
    if (_value.nutriments == null) {
      return null;
    }

    return $NutrimentsCopyWith<$Res>(_value.nutriments!, (value) {
      return _then(_value.copyWith(nutriments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'brands') String? brands,
      @JsonKey(name: 'ingredients_text') String? ingredientsText,
      @JsonKey(name: 'nutriments') Nutriments? nutriments});

  @override
  $NutrimentsCopyWith<$Res>? get nutriments;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? brands = freezed,
    Object? ingredientsText = freezed,
    Object? nutriments = freezed,
  }) {
    return _then(_$ProductImpl(
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      brands: freezed == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredientsText: freezed == ingredientsText
          ? _value.ingredientsText
          : ingredientsText // ignore: cast_nullable_to_non_nullable
              as String?,
      nutriments: freezed == nutriments
          ? _value.nutriments
          : nutriments // ignore: cast_nullable_to_non_nullable
              as Nutriments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {@JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'brands') this.brands,
      @JsonKey(name: 'ingredients_text') this.ingredientsText,
      @JsonKey(name: 'nutriments') this.nutriments});

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'brands')
  final String? brands;
  @override
  @JsonKey(name: 'ingredients_text')
  final String? ingredientsText;
  @override
  @JsonKey(name: 'nutriments')
  final Nutriments? nutriments;

  @override
  String toString() {
    return 'Product(productName: $productName, brands: $brands, ingredientsText: $ingredientsText, nutriments: $nutriments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.brands, brands) || other.brands == brands) &&
            (identical(other.ingredientsText, ingredientsText) ||
                other.ingredientsText == ingredientsText) &&
            (identical(other.nutriments, nutriments) ||
                other.nutriments == nutriments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, productName, brands, ingredientsText, nutriments);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
          {@JsonKey(name: 'product_name') final String? productName,
          @JsonKey(name: 'brands') final String? brands,
          @JsonKey(name: 'ingredients_text') final String? ingredientsText,
          @JsonKey(name: 'nutriments') final Nutriments? nutriments}) =
      _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'brands')
  String? get brands;
  @override
  @JsonKey(name: 'ingredients_text')
  String? get ingredientsText;
  @override
  @JsonKey(name: 'nutriments')
  Nutriments? get nutriments;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Nutriments _$NutrimentsFromJson(Map<String, dynamic> json) {
  return _Nutriments.fromJson(json);
}

/// @nodoc
mixin _$Nutriments {
  @JsonKey(name: 'energy-kcal')
  double? get energyKcal => throw _privateConstructorUsedError;
  @JsonKey(name: 'proteins')
  double? get proteins => throw _privateConstructorUsedError;
  @JsonKey(name: 'fat')
  double? get fat => throw _privateConstructorUsedError;
  @JsonKey(name: 'carbohydrates')
  double? get carbohydrates => throw _privateConstructorUsedError;

  /// Serializes this Nutriments to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Nutriments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutrimentsCopyWith<Nutriments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutrimentsCopyWith<$Res> {
  factory $NutrimentsCopyWith(
          Nutriments value, $Res Function(Nutriments) then) =
      _$NutrimentsCopyWithImpl<$Res, Nutriments>;
  @useResult
  $Res call(
      {@JsonKey(name: 'energy-kcal') double? energyKcal,
      @JsonKey(name: 'proteins') double? proteins,
      @JsonKey(name: 'fat') double? fat,
      @JsonKey(name: 'carbohydrates') double? carbohydrates});
}

/// @nodoc
class _$NutrimentsCopyWithImpl<$Res, $Val extends Nutriments>
    implements $NutrimentsCopyWith<$Res> {
  _$NutrimentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Nutriments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? energyKcal = freezed,
    Object? proteins = freezed,
    Object? fat = freezed,
    Object? carbohydrates = freezed,
  }) {
    return _then(_value.copyWith(
      energyKcal: freezed == energyKcal
          ? _value.energyKcal
          : energyKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      proteins: freezed == proteins
          ? _value.proteins
          : proteins // ignore: cast_nullable_to_non_nullable
              as double?,
      fat: freezed == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double?,
      carbohydrates: freezed == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutrimentsImplCopyWith<$Res>
    implements $NutrimentsCopyWith<$Res> {
  factory _$$NutrimentsImplCopyWith(
          _$NutrimentsImpl value, $Res Function(_$NutrimentsImpl) then) =
      __$$NutrimentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'energy-kcal') double? energyKcal,
      @JsonKey(name: 'proteins') double? proteins,
      @JsonKey(name: 'fat') double? fat,
      @JsonKey(name: 'carbohydrates') double? carbohydrates});
}

/// @nodoc
class __$$NutrimentsImplCopyWithImpl<$Res>
    extends _$NutrimentsCopyWithImpl<$Res, _$NutrimentsImpl>
    implements _$$NutrimentsImplCopyWith<$Res> {
  __$$NutrimentsImplCopyWithImpl(
      _$NutrimentsImpl _value, $Res Function(_$NutrimentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Nutriments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? energyKcal = freezed,
    Object? proteins = freezed,
    Object? fat = freezed,
    Object? carbohydrates = freezed,
  }) {
    return _then(_$NutrimentsImpl(
      energyKcal: freezed == energyKcal
          ? _value.energyKcal
          : energyKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      proteins: freezed == proteins
          ? _value.proteins
          : proteins // ignore: cast_nullable_to_non_nullable
              as double?,
      fat: freezed == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double?,
      carbohydrates: freezed == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutrimentsImpl implements _Nutriments {
  const _$NutrimentsImpl(
      {@JsonKey(name: 'energy-kcal') this.energyKcal,
      @JsonKey(name: 'proteins') this.proteins,
      @JsonKey(name: 'fat') this.fat,
      @JsonKey(name: 'carbohydrates') this.carbohydrates});

  factory _$NutrimentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutrimentsImplFromJson(json);

  @override
  @JsonKey(name: 'energy-kcal')
  final double? energyKcal;
  @override
  @JsonKey(name: 'proteins')
  final double? proteins;
  @override
  @JsonKey(name: 'fat')
  final double? fat;
  @override
  @JsonKey(name: 'carbohydrates')
  final double? carbohydrates;

  @override
  String toString() {
    return 'Nutriments(energyKcal: $energyKcal, proteins: $proteins, fat: $fat, carbohydrates: $carbohydrates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrimentsImpl &&
            (identical(other.energyKcal, energyKcal) ||
                other.energyKcal == energyKcal) &&
            (identical(other.proteins, proteins) ||
                other.proteins == proteins) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, energyKcal, proteins, fat, carbohydrates);

  /// Create a copy of Nutriments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrimentsImplCopyWith<_$NutrimentsImpl> get copyWith =>
      __$$NutrimentsImplCopyWithImpl<_$NutrimentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutrimentsImplToJson(
      this,
    );
  }
}

abstract class _Nutriments implements Nutriments {
  const factory _Nutriments(
          {@JsonKey(name: 'energy-kcal') final double? energyKcal,
          @JsonKey(name: 'proteins') final double? proteins,
          @JsonKey(name: 'fat') final double? fat,
          @JsonKey(name: 'carbohydrates') final double? carbohydrates}) =
      _$NutrimentsImpl;

  factory _Nutriments.fromJson(Map<String, dynamic> json) =
      _$NutrimentsImpl.fromJson;

  @override
  @JsonKey(name: 'energy-kcal')
  double? get energyKcal;
  @override
  @JsonKey(name: 'proteins')
  double? get proteins;
  @override
  @JsonKey(name: 'fat')
  double? get fat;
  @override
  @JsonKey(name: 'carbohydrates')
  double? get carbohydrates;

  /// Create a copy of Nutriments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutrimentsImplCopyWith<_$NutrimentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
