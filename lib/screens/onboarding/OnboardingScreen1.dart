import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  // Состояние для значений каруселей
  int _height = 170; // Начальное значение роста
  int _weight = 70;  // Начальное значение веса
  int _age = 25;     // Начальное значение возраста
  bool _isFemale = true; // Состояние для пола (false = Male, true = Female)

  // Контроллеры для управления каруселями
  final FixedExtentScrollController _heightController = FixedExtentScrollController(initialItem: 40);
  final FixedExtentScrollController _weightController = FixedExtentScrollController(initialItem: 40);
  final FixedExtentScrollController _ageController = FixedExtentScrollController(initialItem: 15);

  final maxHeight = 220;
  final minHeight = 130;
  final maxWeight = 220;
  final minWeight = 30;
  final maxAge = 100;
  final minAge = 10;

  @override
  void initState() {
    super.initState();
    // Установка начальных позиций контроллеров

  }

  @override
  void dispose() {
    // Освобождение контроллеров
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // Функции для изменения значений
  void _updateHeight(int value) {
    setState(() {
      _height = value.clamp(minHeight, maxHeight);
    });
  }

  void _updateWeight(int value) {
    setState(() {
      _weight = value.clamp(minWeight, maxWeight);
    });
  }

  void _updateAge(int value) {
    setState(() {
      _age = value.clamp(minAge, maxAge);
    });
  }

  void _toggleGender(bool value) {
    setState(() {
      _isFemale = value; // Прямое обновление состояния (true = Female, false = Male)
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.getBackground(context),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.getBackground(context),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => context.go('/onboarding2'),
                child: Text(
                  'Skip',
                  style: TextStyle(color: AppColors.getTextSubtitle(context)),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Text(
                    'Let’s Get Started!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.getText(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Горизонтальная линия с каруселями
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Блок для роста
                      _buildSelectorBlock(
                        title: 'Height (cm)',
                        value: _height,
                        minValue: minHeight,
                        maxValue: maxHeight,
                        onValueChanged: _updateHeight,
                        controller: _heightController,
                      ),
                      const SizedBox(width: 16), // Отступ между блоками
                      // Блок для веса
                      _buildSelectorBlock(
                        title: 'Weight (kg)',
                        value: _weight,
                        minValue: minWeight,
                        maxValue: maxWeight,
                        onValueChanged: _updateWeight,
                        controller: _weightController,
                      ),
                      const SizedBox(width: 16), // Отступ между блоками
                      // Блок для возраста
                      _buildSelectorBlock(
                        title: 'Age',
                        value: _age,
                        minValue: minAge,
                        maxValue: maxAge,
                        onValueChanged: _updateAge,
                        controller: _ageController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Выбор пола
                  Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.getText(context).withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Male'),
                        Switch(
                          value: _isFemale, // Прямое использование состояния
                          onChanged: _toggleGender,
                          activeColor: AppColors.getPrimary(context),
                          activeTrackColor: AppColors.getPrimary(context).withOpacity(0.5),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.5),
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                ],
              ),
              // Кнопка прижата к низу
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('User selected values:');
                    print('Height: $_height cm');
                    print('Weight: $_weight kg');
                    print('Age: $_age years');
                    print('Gender: ${_isFemale ? 'Female' : 'Male'}');
                    // Здесь можно добавить логику сохранения данных (рост, вес, возраст, пол)
                    context.go('/onboarding2');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getPrimary(context),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Виджет для каждого блока селектора с каруселью
  Widget _buildSelectorBlock({
    required String title,
    required int value,
    required int minValue,
    required int maxValue,
    required Function(int) onValueChanged,
    required FixedExtentScrollController controller,
  }) {

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.getText(context).withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.getText(context).withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              height: 150, // Высота карусели
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50, // Размер каждого элемента
                perspective: 0.005,
                diameterRatio: 1.4,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  final newValue = minValue + index;
                  onValueChanged(newValue);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: maxValue - minValue + 1,
                  builder: (context, index) {
                    final displayValue = minValue + index;
                    final isSelected = displayValue == value;
                    return Center(
                      child: Text(
                        '$displayValue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? AppColors.getText(context)
                              : AppColors.getTextSubtitle(context),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}