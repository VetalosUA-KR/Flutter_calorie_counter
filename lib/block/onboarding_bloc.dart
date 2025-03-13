import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/user_profile_repository.dart';
import 'package:flutterhelloworld/user_profile.dart';
import 'package:flutterhelloworld/nutrition_profile.dart';
import 'package:hive/hive.dart';

/*part 'onboarding_event.dart';
part 'onboarding_state.dart';*/

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UserProfileRepository repository;

  OnboardingBloc({required this.repository}) : super(OnboardingInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  /*@override
  void onTransition(Transition<OnboardingEvent, OnboardingState> transition) {
    print('Transition from ${transition.currentState} to ${transition.nextState}');
    super.onTransition(transition);
  }*/

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<OnboardingState> emit) async {
    final profile = repository.getProfile();
    emit(OnboardingLoaded(profile: profile));
  }

  Future<void> _onUpdateUserProfile(UpdateUserProfile event, Emitter<OnboardingState> emit) async {
    final updatedProfile = UserProfile(
      height: event.height,
      weight: event.weight,
      age: event.age,
      activityLevel: event.activityLevel,
      isFemale: event.isFemale,
    );
    await repository.saveProfile(updatedProfile);

    // Расчёт КБЖУ
    final nutritionProfile = _calculateNutritionProfile(updatedProfile);
    await Hive.box<NutritionProfile>('nutritionProfileBox').put('nutrition', nutritionProfile);

    emit(OnboardingLoaded(profile: updatedProfile));
  }

  NutritionProfile _calculateNutritionProfile(UserProfile profile) {
    // Расчёт BMR (формула Миффлина-Сан Жеора)
    double bmr;
    if (profile.isFemale) {
      bmr = (10 * profile.weight) + (6.25 * profile.height) - (5 * profile.age) - 161;
    } else {
      bmr = (10 * profile.weight) + (6.25 * profile.height) - (5 * profile.age) + 5;
    }

    // Умножаем BMR на уровень активности
    final totalCalories = bmr * profile.activityLevel;

    // Распределение макронутриентов
    final proteinCalories = totalCalories * 0.25; // 25% калорий на белки
    final fatCalories = totalCalories * 0.25;     // 25% калорий на жиры
    final carbCalories = totalCalories * 0.50;    // 50% калорий на углеводы

    final protein = double.parse((proteinCalories / 4).toStringAsFixed(1)); // 1 г белка = 4 ккал, с точностью до 1 знака
    final fat = double.parse((fatCalories / 9).toStringAsFixed(1));         // 1 г жира = 9 ккал, с точностью до 1 знака
    final carbs = double.parse((carbCalories / 4).toStringAsFixed(1));      // 1 г углевода = 4 ккал, с точностью до 1 знака

    return NutritionProfile(
      calories: double.parse(totalCalories.toStringAsFixed(1)), // Калории с точностью до 1 знака
      protein: protein,
      fat: fat,
      carbs: carbs,
    );
  }
}

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends OnboardingEvent {}

class UpdateUserProfile extends OnboardingEvent {
  final int height;
  final int weight;
  final int age;
  final double activityLevel;
  final bool isFemale;

  const UpdateUserProfile({
    required this.height,
    required this.weight,
    required this.age,
    required this.activityLevel,
    required this.isFemale,
  });

  @override
  List<Object?> get props => [height, weight, age, activityLevel, isFemale];
}

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final UserProfile profile;

  const OnboardingLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}