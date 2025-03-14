// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutritionProfileAdapter extends TypeAdapter<NutritionProfile> {
  @override
  final int typeId = 1;

  @override
  NutritionProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionProfile(
      calories: fields[0] as double,
      protein: fields[1] as double,
      fat: fields[2] as double,
      carbs: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.carbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
