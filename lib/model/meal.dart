import 'package:hive/hive.dart';

part 'meal.g.dart'; // Перемещено перед всеми объявлениями

// Перечисление для типов приёма пищи
@HiveType(typeId: 4) // Добавляем адаптер для enum
enum MealType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack,
}

@HiveType(typeId: 5)
class Meal extends HiveObject {
  @HiveField(0)
  String name; // Название блюда (например, "Овсянка")

  @HiveField(1)
  double calories; // Калории (ккал)

  @HiveField(2)
  double protein; // Белки (г)

  @HiveField(3)
  double fat; // Жиры (г)

  @HiveField(4)
  double carbs; // Углеводы (г)

  @HiveField(5)
  MealType type; // Тип приёма пищи

  Meal({
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.type,
  })  : assert(calories >= 0, 'Calories cannot be negative'),
        assert(protein >= 0, 'Protein cannot be negative'),
        assert(fat >= 0, 'Fat cannot be negative'),
        assert(carbs >= 0, 'Carbs cannot be negative');
}