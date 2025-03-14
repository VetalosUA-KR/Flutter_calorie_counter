import 'package:flutter/material.dart';
import 'package:flutterhelloworld/model/meal.dart';
import 'package:flutterhelloworld/theme/app_colors.dart';

class SearchDatabaseBottomSheet extends StatelessWidget {
  final Function(Meal) onAddMeal;
  final MealType mealType;

  const SearchDatabaseBottomSheet({
    super.key,
    required this.onAddMeal,
    required this.mealType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Database - ${mealType.toString().split('.').last}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.getText(context),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Функция в разработке'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}