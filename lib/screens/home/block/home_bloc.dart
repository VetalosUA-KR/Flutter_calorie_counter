import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../model/nutrition_profile.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:flutterhelloworld/repository/stats_repository.dart';
import '../../../repository/remote/remote_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StatsRepository statsRepository;
  final RemoteRepository remoteRepository;

  HomeBloc({
    required this.statsRepository,
    required this.remoteRepository,
  }) : super(const HomeState()) {
    on<LoadNutritionProfileEvent>(_onLoadNutritionProfile);
    on<AddMealEvent>(_onAddMeal);
    on<AddActivityEvent>(_onAddActivity);
  }

  Future<void> _onLoadNutritionProfile(
      LoadNutritionProfileEvent event, Emitter<HomeState> emit) async {
    final box = Hive.box<NutritionProfile>('nutritionProfileBox');
    final nutrition = box.get('nutrition');
    if (nutrition != null) {
      final stats = statsRepository.getStatsForDay(DateTime.now());
      final consumedValues = {
        'calories': stats?.totalCalories ?? 0.0,
        'protein': stats?.totalProtein ?? 0.0,
        'fat': stats?.totalFat ?? 0.0,
        'carbs': stats?.totalCarbs ?? 0.0,
      };
      emit(state.copyWith(
        nutritionProfile: nutrition,
        consumedValues: consumedValues,
      ));

      /*// Пример загрузки данных с API (опционально)
      final product = await remoteRepository.fetchProductByBarcode('737628064502');
      if (product != null && product.product?.nutriments != null) {
        print('Fetched product: ${product.product?.productName}');
        print('Nutriments: ${product.product?.nutriments}');
      }*/

      // Анимация прогресс-бара
      for (double i = 0; i <= 1.0; i += 0.01) {
        await Future.delayed(const Duration(milliseconds: 10));
        emit(state.copyWith(progressAnimationValue: i));
      }
    }
  }

  Future<void> _onAddMeal(AddMealEvent event, Emitter<HomeState> emit) async {
    // Добавляем приём пищи через StatsRepository
    await statsRepository.addMeal(DateTime.now(), event.meal);

    // Обновляем состояние
    final stats = statsRepository.getStatsForDay(DateTime.now());
    final consumedValues = {
      'calories': stats?.totalCalories ?? 0.0,
      'protein': stats?.totalProtein ?? 0.0,
      'fat': stats?.totalFat ?? 0.0,
      'carbs': stats?.totalCarbs ?? 0.0,
    };
    emit(state.copyWith(
      consumedValues: consumedValues,
      progressAnimationValue: 0.0, // Сбрасываем анимацию
    ));

    // Запускаем анимацию заново
    for (double i = 0; i <= 1.0; i += 0.01) {
      await Future.delayed(const Duration(milliseconds: 10));
      emit(state.copyWith(progressAnimationValue: i));
    }

    // Вызываем лямбду, если она передана
    event.onMealAdded?.call();
  }

  Future<void> _onAddActivity(AddActivityEvent event, Emitter<HomeState> emit) async {
    // Добавляем активность через StatsRepository
    await statsRepository.addActivity(DateTime.now(), event.activity);

    // Обновляем состояние
    final stats = statsRepository.getStatsForDay(DateTime.now());
    final consumedValues = {
      'calories': stats?.totalCalories ?? 0.0,
      'protein': stats?.totalProtein ?? 0.0,
      'fat': stats?.totalFat ?? 0.0,
      'carbs': stats?.totalCarbs ?? 0.0,
    };
    emit(state.copyWith(
      consumedValues: consumedValues,
      progressAnimationValue: 0.0, // Сбрасываем анимацию
    ));

    // Запускаем анимацию заново
    for (double i = 0; i <= 1.0; i += 0.01) {
      await Future.delayed(const Duration(milliseconds: 10));
      emit(state.copyWith(progressAnimationValue: i));
    }

    // Вызываем лямбду, если она передана
    event.onActivityAdded?.call();
  }

}