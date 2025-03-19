import 'package:flutter/material.dart';
import 'package:flutterhelloworld/model/meal.dart';
import 'package:flutterhelloworld/navigation/Destination.dart';
import 'package:flutterhelloworld/screens/home/widgets/meal/manual_entry_bottom_sheet.dart';
import 'package:flutterhelloworld/screens/home/widgets/meal/scan_barcode_bottom_sheet.dart';
import 'package:flutterhelloworld/screens/home/widgets/meal/search_database_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

class AddMealBottomSheet extends StatelessWidget {
  final Function(Meal) onAddMeal;
  final MealType mealType;

  const AddMealBottomSheet({
    super.key,
    required this.onAddMeal,
    required this.mealType,
  });

  void _openManualEntry(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ManualEntryBottomSheet(
        onAddMeal: onAddMeal,
        mealType: mealType,
      ),
    );
  }

  void _openScanBarcode(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ScanBarcodeBottomSheet(
        onAddMeal: onAddMeal,
        mealType: mealType,
      ),
    );
  }

  void _openMealScreen(BuildContext context) {
    print('Opening MealScreen with mealType: $mealType');
    Navigator.pop(context); // Закрываем BottomSheet
    GoRouter.of(context).push(
      Uri(
        path: Desctinations.Meal,
        queryParameters: {'mealType': mealType.toString().split('.').last},
      ).toString(),
      extra: onAddMeal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Input Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 40),
                onPressed: () => _openManualEntry(context),
                tooltip: 'Manual Entry',
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, size: 40),
                onPressed: () => _openScanBarcode(context),
                tooltip: 'Scan Barcode',
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 40),
                onPressed: () => _openMealScreen(context),
                tooltip: 'Search Database',
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}