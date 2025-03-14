import 'package:hive/hive.dart';

part 'nutrition_profile.g.dart';

@HiveType(typeId: 1) // Уникальный typeId для Hive
class NutritionProfile extends HiveObject {
  @HiveField(0)
  double calories; // Калории (ккал)

  @HiveField(1)
  double protein;  // Белки (г)

  @HiveField(2)
  double fat;      // Жиры (г)

  @HiveField(3)
  double carbs;    // Углеводы (г)

  NutritionProfile({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  // Фабричный конструктор для начальных значений
  factory NutritionProfile.initial() => NutritionProfile(
    calories: 0.0,
    protein: 0.0,
    fat: 0.0,
    carbs: 0.0,
  );

  // Преобразование в строку для отладки
  @override
  String toString() =>
      'NutritionProfile(calories: $calories, protein: $protein, fat: $fat, carbs: $carbs)';
}