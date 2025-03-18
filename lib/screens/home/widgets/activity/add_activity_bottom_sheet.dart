import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhelloworld/model/activity.dart';
import 'package:flutterhelloworld/screens/home/widgets/activity/SportActivityType.dart'; // Импортируем перечисление

class AddSportActivityBottomSheet extends StatefulWidget {
  final Function(Activity) onAddActivity; // Колбэк для добавления активности

  const AddSportActivityBottomSheet({
    super.key,
    required this.onAddActivity,
  });

  @override
  State<AddSportActivityBottomSheet> createState() => _AddSportActivityBottomSheetState();
}

class _AddSportActivityBottomSheetState extends State<AddSportActivityBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _durationController = TextEditingController();
  SportActivityType? _selectedActivityType;

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedActivityType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an activity type')),
      );
      return;
    }

    final duration = int.tryParse(_durationController.text) ?? 0;
    final burnedCalories = _selectedActivityType!.caloriesPerMinute * duration;

    final activity = Activity(
      type: _selectedActivityType!.displayName, // Используем строковое значение
      duration: duration,
      burnedCalories: burnedCalories, // Рассчитываем калории
      intensity: 1.0, // Интенсивность по умолчанию
    );

    widget.onAddActivity(activity); // Передаем активность в колбэк
    Navigator.pop(context); // Закрываем BottomSheet
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
              const Text(
                'Add Sport Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<SportActivityType>(
                value: _selectedActivityType,
                decoration: InputDecoration(
                  labelText: 'Activity Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: SportActivityType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName), // Отображаем строковое значение
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedActivityType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an activity type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duration (minutes)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
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
                    'Add Activity',
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