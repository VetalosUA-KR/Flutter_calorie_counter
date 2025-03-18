import 'package:flutter/material.dart';
import 'package:flutterhelloworld/model/activity.dart';
import 'package:flutterhelloworld/model/meal.dart';

abstract class HomeEvent {}

class LoadNutritionProfileEvent extends HomeEvent {}

class AddActivityEvent extends HomeEvent {
  final Activity activity;
  final VoidCallback? onActivityAdded; // Лямбда, которая будет вызвана после добавления активности

  AddActivityEvent(this.activity, {this.onActivityAdded});
}

class AddMealEvent extends HomeEvent {
  final Meal meal;
  final VoidCallback? onMealAdded; // Лямбда, которая будет вызвана после добавления приема пищи
  AddMealEvent(this.meal, {this.onMealAdded});
}