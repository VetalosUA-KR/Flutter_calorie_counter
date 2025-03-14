import 'package:hive/hive.dart';
import 'nutrition_profile.dart';
import 'meal.dart';
import 'activity.dart';

part 'daily_stats.g.dart';

@HiveType(typeId: 3)
class DailyStats extends HiveObject {
  @HiveField(0)
  DateTime date; // Дата

  @HiveField(1)
  Map<MealType, List<Meal>> mealsByType; // Приёмы пищи по категориям

  @HiveField(2)
  List<Activity> activities; // Список активностей

  DailyStats({
    required this.date,
    Map<MealType, List<Meal>>? mealsByType,
    this.activities = const [],
  }) : mealsByType = mealsByType ?? {
    MealType.breakfast: [],
    MealType.lunch: [],
    MealType.dinner: [],
    MealType.snack: [],
  };

  // Получение общей статистики по макронутриентам за день
  double get totalCalories => mealsByType.values
      .expand((meals) => meals)
      .fold(0.0, (sum, meal) => sum + meal.calories);
  double get totalProtein => mealsByType.values
      .expand((meals) => meals)
      .fold(0.0, (sum, meal) => sum + meal.protein);
  double get totalFat => mealsByType.values
      .expand((meals) => meals)
      .fold(0.0, (sum, meal) => sum + meal.fat);
  double get totalCarbs => mealsByType.values
      .expand((meals) => meals)
      .fold(0.0, (sum, meal) => sum + meal.carbs);
  double get totalBurnedCalories =>
      activities.fold(0.0, (sum, activity) => sum + activity.burnedCalories);

  // Статистика по категориям
  Map<MealType, double> get caloriesByMealType {
    final result = <MealType, double>{};
    for (var type in MealType.values) {
      final meals = mealsByType[type]; // Получаем список приёмов пищи
      if (meals != null && meals.isNotEmpty) {
        result[type] = meals.fold(0.0, (double sum, Meal meal) => sum + meal.calories);
      } else {
        result[type] = 0.0;
      }
    }
    return result;
  }

  // Процент выполнения целей (по сравнению с NutritionProfile)
  Map<String, double> progressTowardsGoals(NutritionProfile target) {
    return {
      'calories': (totalCalories / target.calories).clamp(0.0, 1.0) * 100,
      'protein': (totalProtein / target.protein).clamp(0.0, 1.0) * 100,
      'fat': (totalFat / target.fat).clamp(0.0, 1.0) * 100,
      'carbs': (totalCarbs / target.carbs).clamp(0.0, 1.0) * 100,
    };
  }

  // Средняя интенсивность активности
  double get averageIntensity =>
      activities.isNotEmpty ? activities.map((a) => a.intensity).reduce((a, b) => a + b) / activities.length : 0.0;
}