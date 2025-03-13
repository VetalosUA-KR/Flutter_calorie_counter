// lib/screens/home/bloc/home_state.dart
import 'package:equatable/equatable.dart';
import '../../../nutrition_profile.dart';

class HomeState extends Equatable {
  final NutritionProfile? nutritionProfile;
  final Map<String, double> consumedValues;
  final double progressAnimationValue;

  const HomeState({
    this.nutritionProfile,
    this.consumedValues = const {
      'calories': 0.0,
      'protein': 0.0,
      'fat': 0.0,
      'carbs': 0.0,
    },
    this.progressAnimationValue = 0.0,
  });

  HomeState copyWith({
    NutritionProfile? nutritionProfile,
    Map<String, double>? consumedValues,
    double? progressAnimationValue,
  }) {
    return HomeState(
      nutritionProfile: nutritionProfile ?? this.nutritionProfile,
      consumedValues: consumedValues ?? this.consumedValues,
      progressAnimationValue: progressAnimationValue ?? this.progressAnimationValue,
    );
  }

  @override
  List<Object?> get props => [nutritionProfile, consumedValues, progressAnimationValue];
}