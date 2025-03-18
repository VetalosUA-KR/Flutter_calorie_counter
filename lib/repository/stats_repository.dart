import 'package:hive/hive.dart';
import '../model/daily_stats.dart';
import '../model/meal.dart';
import '../model/activity.dart';
import '../model/nutrition_profile.dart';

class StatsRepository {
  static const String _boxName = 'dailyStatsBox';
  late Box<DailyStats> _box;

  StatsRepository() {
    _box = Hive.box<DailyStats>(_boxName);
  }

  // Получение всей статистики
  List<DailyStats> getAllStats() {
    return _box.values.toList();
  }

  // Получение статистики за конкретный день
  DailyStats? getStatsForDay(DateTime date) {
    return _box.values.firstWhere(
          (stats) => _isSameDay(stats.date, date),
      orElse: () => DailyStats(date: date),
    );
  }

  // Получение статистики за неделю
  List<DailyStats> getStatsForWeek(DateTime weekStart) {
    final start = weekStart.subtract(Duration(days: weekStart.weekday - 1)); // Начало недели (понедельник)
    final end = start.add(const Duration(days: 6)); // Конец недели (воскресенье)
    return _box.values.where((stats) {
      return stats.date.isAfter(start.subtract(const Duration(days: 1))) &&
          stats.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  // Агрегированная статистика за неделю
  Map<String, double> getWeeklyStats(List<DailyStats> weekStats, NutritionProfile target) {
    final totalDays = weekStats.length;
    if (totalDays == 0) return {'calories': 0, 'protein': 0, 'fat': 0, 'carbs': 0, 'burnedCalories': 0};

    final total = {
      'calories': weekStats.fold(0.0, (sum, stats) => sum + stats.totalCalories),
      'protein': weekStats.fold(0.0, (sum, stats) => sum + stats.totalProtein),
      'fat': weekStats.fold(0.0, (sum, stats) => sum + stats.totalFat),
      'carbs': weekStats.fold(0.0, (sum, stats) => sum + stats.totalCarbs),
      'burnedCalories': weekStats.fold(0.0, (sum, stats) => sum + stats.totalBurnedCalories),
    };

    return {
      'avgCalories': total['calories']! / totalDays,
      'avgProtein': total['protein']! / totalDays,
      'avgFat': total['fat']! / totalDays,
      'avgCarbs': total['carbs']! / totalDays,
      'avgBurnedCalories': total['burnedCalories']! / totalDays,
      'progressCalories': (total['calories']! / (target.calories * totalDays)).clamp(0.0, 1.0) * 100,
      'progressProtein': (total['protein']! / (target.protein * totalDays)).clamp(0.0, 1.0) * 100,
      'progressFat': (total['fat']! / (target.fat * totalDays)).clamp(0.0, 1.0) * 100,
      'progressCarbs': (total['carbs']! / (target.carbs * totalDays)).clamp(0.0, 1.0) * 100,
    };
  }

  // Добавление/обновление статистики за день
  Future<void> updateStats(DailyStats stats) async {
    final existingStats = getStatsForDay(stats.date);
    if (existingStats != null && existingStats.key != null) {
      await _box.put(existingStats.key, stats);
    } else {
      await _box.add(stats);
    }
  }

  // Добавление приёма пищи за день
  Future<void> addMeal(DateTime date, Meal meal) async {
    final stats = getStatsForDay(date) ?? DailyStats(date: date);
    final mealsForType = List<Meal>.from(stats.mealsByType[meal.type] ?? []);
    mealsForType.add(meal);
    stats.mealsByType[meal.type] = mealsForType;
    await updateStats(stats);

  }

  // Удаление приёма пищи за день
  Future<void> removeMeal(DateTime date, MealType type, int mealIndex) async {
    final stats = getStatsForDay(date);
    if (stats != null) {
      final mealsForType = List<Meal>.from(stats.mealsByType[type] ?? []);
      if (mealIndex < mealsForType.length) {
        mealsForType.removeAt(mealIndex);
        stats.mealsByType[type] = mealsForType;
        await updateStats(stats);
      }
    }
  }

  // Добавление активности за день
  Future<void> addActivity(DateTime date, Activity activity) async {
    final stats = getStatsForDay(date) ?? DailyStats(date: date);
    stats.activities = [...stats.activities, activity];
    await updateStats(stats);
  }

  // Удаление активности за день
  Future<void> removeActivity(DateTime date, int activityIndex) async {
    final stats = getStatsForDay(date);
    if (stats != null) {
      stats.activities = List.from(stats.activities)..removeAt(activityIndex);
      await updateStats(stats);
    }
  }

  // Удаление всей статистики за день
  Future<void> deleteStatsForDay(DateTime date) async {
    final stats = getStatsForDay(date);
    if (stats != null && stats.key != null) {
      await _box.delete(stats.key);
    }
  }

  // Утилита для сравнения дат
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}