// lib/screens/home/bloc/home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../nutrition_profile.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadNutritionProfileEvent>(_onLoadNutritionProfile);
  }

  Future<void> _onLoadNutritionProfile(LoadNutritionProfileEvent event, Emitter<HomeState> emit) async {
    final box = Hive.box<NutritionProfile>('nutritionProfileBox');
    final nutrition = box.get('nutrition');
    if (nutrition != null) {
      final consumedValues = {
        'calories': nutrition.calories * 0.5,
        'protein': nutrition.protein * 0.5,
        'fat': nutrition.fat * 0.5,
        'carbs': nutrition.carbs * 0.5,
      };
      emit(state.copyWith(
        nutritionProfile: nutrition,
        consumedValues: consumedValues,
      ));
      // Анимация прогресс-бара
      for (double i = 0; i <= 1.0; i += 0.01) {
        await Future.delayed(const Duration(milliseconds: 10));
        emit(state.copyWith(progressAnimationValue: i));
      }
    }
  }
}