import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  int height;

  @HiveField(1)
  int weight;

  @HiveField(2)
  int age;

  @HiveField(3)
  bool isFemale;

  UserProfile({
    required this.height,
    required this.weight,
    required this.age,
    required this.isFemale,
  });

  // Фабричный конструктор для создания экземпляра из значений по умолчанию
  factory UserProfile.initial() => UserProfile(
    height: 170,
    weight: 70,
    age: 25,
    isFemale: true,
  );

  // Преобразование в строку для отладки
  @override
  String toString() => 'UserProfile(height: $height, weight: $weight, age: $age, isFemale: $isFemale)';
}