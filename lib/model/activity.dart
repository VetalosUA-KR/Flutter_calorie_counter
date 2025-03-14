import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 2)
class Activity extends HiveObject {
  @HiveField(0)
  String type; // Тип активности (например, "Бег", "Йога")

  @HiveField(1)
  int duration; // Продолжительность (в минутах)

  @HiveField(2)
  double burnedCalories; // Сожжённые калории (ккал)

  @HiveField(3)
  double intensity; // Интенсивность (1.0 - низкая, 2.0 - средняя, 3.0 - высокая)

  Activity({
    required this.type,
    required this.duration,
    required this.burnedCalories,
    required this.intensity,
  })  : assert(duration >= 0, 'Duration cannot be negative'),
        assert(burnedCalories >= 0, 'Burned calories cannot be negative'),
        assert(intensity >= 1.0 && intensity <= 3.0, 'Intensity must be between 1.0 and 3.0');
}