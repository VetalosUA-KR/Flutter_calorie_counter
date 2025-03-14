import 'package:flutterhelloworld/meal.dart';

abstract class HomeEvent {}

class LoadNutritionProfileEvent extends HomeEvent {}

class AddMealEvent extends HomeEvent {
  final Meal meal;
  AddMealEvent(this.meal);
}