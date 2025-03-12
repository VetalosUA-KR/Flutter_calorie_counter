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
  bool _isFemale = false; // Состояние для пола

  // Контроллеры для управления каруселями (инициализированы сразу)
  final FixedExtentScrollController _heightController = FixedExtentScrollController();
  final FixedExtentScrollController _weightController = FixedExtentScrollController();
  final FixedExtentScrollController _ageController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    // Установка начальных позиций контроллеров
    _heightController.jumpToItem(_height - 170);
    _weightController.jumpToItem(_weight - 70);
    _ageController.jumpToItem(_age - 20);
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
      _height = value.clamp(150, 220);
      _heightController.jumpToItem(_height - 150); // Прокрутка карусели
    });
  }

  void _updateWeight(int value) {
    setState(() {
      _weight = value.clamp(30, 150);
      _weightController.jumpToItem(_weight - 30); // Прокрутка карусели
    });
  }

  void _updateAge(int value) {
    setState(() {
      _age = value.clamp(10, 100);
      _ageController.jumpToItem(_age - 10); // Прокрутка карусели
    });
  }

  void _toggleGender(bool value) => setState(() => _isFemale = value);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.getBackground(context),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => context.go('/onboarding2'),
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    minValue: 150,
                    maxValue: 220,
                    onValueChanged: _updateHeight,
                    controller: _heightController,
                  ),
                  // Блок для веса
                  _buildSelectorBlock(
                    title: 'Weight (kg)',
                    value: _weight,
                    minValue: 30,
                    maxValue: 150,
                    onValueChanged: _updateWeight,
                    controller: _weightController,
                  ),
                  // Блок для возраста
                  _buildSelectorBlock(
                    title: 'Age',
                    value: _age,
                    minValue: 10,
                    maxValue: 100,
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
                      value: !_isFemale, // Инверсия, чтобы Male = true, Female = false
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
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
            ],
          ),
        ),
      ),
    );
  }

  // Виджет для каждого блока селектора с каруселью и стрелочками
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: () => onValueChanged(value + 1),
                  color: AppColors.getPrimary(context),
                ),
                SizedBox(
                  height: 80, // Высота карусели
                  child: ListWheelScrollView.useDelegate(
                    controller: controller,
                    itemExtent: 40, // Размер каждого элемента
                    perspective: 0.005,
                    diameterRatio: 1.2,
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
                                  : AppColors.getHint(context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onPressed: () => onValueChanged(value - 1),
                  color: AppColors.getPrimary(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}