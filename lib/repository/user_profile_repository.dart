import 'package:hive/hive.dart';
import '../user_profile.dart';

class UserProfileRepository {
  final Box<UserProfile> _box;

  UserProfileRepository(this._box);

  // Получение профиля (возвращает начальные значения, если данные отсутствуют)
  UserProfile getProfile() {
    try {
      return _box.get('userProfile') ?? UserProfile.initial();
    } catch (e) {
      print('Error loading profile: $e');
      return UserProfile.initial();
    }
  }

  // Сохранение профиля
  Future<void> saveProfile(UserProfile profile) async {
    try {
      await _box.put('userProfile', profile);
    } catch (e) {
      print('Error saving profile: $e');
      throw Exception('Failed to save profile');
    }
  }
}