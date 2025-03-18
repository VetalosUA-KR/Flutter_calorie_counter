import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutterhelloworld/model/meal.dart';
import 'package:flutterhelloworld/repository/remote/remote_repository.dart';
import 'package:flutterhelloworld/theme/app_colors.dart';

class ScanBarcodeBottomSheet extends StatefulWidget {
  final Function(Meal) onAddMeal;
  final MealType mealType;

  const ScanBarcodeBottomSheet({
    super.key,
    required this.onAddMeal,
    required this.mealType,
  });

  @override
  State<ScanBarcodeBottomSheet> createState() => _ScanBarcodeBottomSheetState();
}

class _ScanBarcodeBottomSheetState extends State<ScanBarcodeBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbsController = TextEditingController();
  final _percentageController = TextEditingController(text: '100');
  final RemoteRepository _remoteRepository = RemoteRepository();

  double _baseCalories = 0.0;
  double _baseProtein = 0.0;
  double _baseFat = 0.0;
  double _baseCarbs = 0.0;

  @override
  void initState() {
    super.initState();
    _percentageController.addListener(_updateNutrientValues);
    _scanBarcode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _carbsController.dispose();
    _percentageController.removeListener(_updateNutrientValues);
    _percentageController.dispose();
    super.dispose();
  }

  void _updateNutrientValues() {
    double percentage = double.tryParse(_percentageController.text) ?? 100.0;
    if (percentage < 0 || percentage > 100) {
      percentage = 100.0;
      _percentageController.text = '100';
    }

    setState(() {
      _caloriesController.text = (_baseCalories * (percentage / 100)).toStringAsFixed(0);
      _proteinController.text = (_baseProtein * (percentage / 100)).toStringAsFixed(1);
      _fatController.text = (_baseFat * (percentage / 100)).toStringAsFixed(1);
      _carbsController.text = (_baseCarbs * (percentage / 100)).toStringAsFixed(1);
    });
  }

  Future<void> _scanBarcode() async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      try {
        final result = await BarcodeScanner.scan();
        final barcode = result.rawContent;
        await _fetchProductInfo(barcode);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка сканирования: $e')),
        );
        Navigator.pop(context);
      }
    } else if (cameraStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Разрешение на камеру не предоставлено')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _fetchProductInfo(String barcode) async {
    final productResponse = await _remoteRepository.fetchProductByBarcode(barcode);
    if (productResponse != null && productResponse.product?.nutriments != null) {
      final product = productResponse.product!;
      final nutriments = product.nutriments!;
      setState(() {
        _nameController.text = product.productName ?? 'Unknown Product';
        _baseCalories = nutriments.energyKcal ?? 0.0;
        _baseProtein = nutriments.proteins ?? 0.0;
        _baseFat = nutriments.fat ?? 0.0;
        _baseCarbs = nutriments.carbohydrates ?? 0.0;
        _updateNutrientValues();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные о продукте не найдены')),
      );
      Navigator.pop(context);
    }
  }

  void _submit() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    double percentage = double.tryParse(_percentageController.text) ?? 100.0;
    if (percentage < 0 || percentage > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Процент должен быть от 0 до 100')),
      );
      return;
    }

    final meal = Meal(
      name: _nameController.text.isNotEmpty ? _nameController.text : 'Unknown Product',
      calories: double.tryParse(_caloriesController.text) ?? 0.0,
      protein: double.tryParse(_proteinController.text) ?? 0.0,
      fat: double.tryParse(_fatController.text) ?? 0.0,
      carbs: double.tryParse(_carbsController.text) ?? 0.0,
      type: widget.mealType,
    );
    widget.onAddMeal(meal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scanned Product - ${widget.mealType.toString().split('.').last}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getText(context),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Meal Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                enabled: false,
                validator: (value) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _caloriesController,
                decoration: InputDecoration(
                  labelText: 'Calories (kcal)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                enabled: false,
                validator: (value) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _proteinController,
                decoration: InputDecoration(
                  labelText: 'Protein (g)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                enabled: false,
                validator: (value) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fatController,
                decoration: InputDecoration(
                  labelText: 'Fat (g)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                enabled: false,
                validator: (value) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _carbsController,
                decoration: InputDecoration(
                  labelText: 'Carbs (g)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                enabled: false,
                validator: (value) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _percentageController,
                decoration: InputDecoration(
                  labelText: 'Percentage Eaten (%)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter percentage';
                  }
                  final percentage = double.tryParse(value);
                  if (percentage == null || percentage < 0 || percentage > 100) {
                    return 'Percentage must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}