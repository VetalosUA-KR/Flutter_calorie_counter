import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../block/onboarding_bloc.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {

  int _height = 170; // Начальное значение роста
  int _weight = 70;  // Начальное значение веса
  int _age = 25;     // Начальное значение возраста
  double _activityLevel = 1.357;     // Начальное значение возраста
  bool _isFemale = true; // Состояние для пола (false = Male, true = Female)

  final maxHeight = 220;
  final minHeight = 130;
  final maxWeight = 220;
  final minWeight = 30;
  final maxAge = 100;
  final minAge = 10;

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
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(LoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = (state as OnboardingLoaded).profile;

        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: AppColors.getBackground(context),
            body: Padding(
              //padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              padding: const EdgeInsets.fromLTRB(16.0, 140.0, 16.0, 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      // Индикатор прогресса (2 шага онбординга)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 10, // Ширина точки
                            height: 10, // Высота точки
                            margin: const EdgeInsets.symmetric(horizontal: 4), // Отступ между точками
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.getPrimary(context),
                            ),
                          ),
                          Container(
                            width: 10, // Ширина точки
                            height: 10, // Высота точки
                            margin: const EdgeInsets.symmetric(horizontal: 4), // Отступ между точками
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.getText(context).withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Отступ между индикатором и заголовком
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSelectorBlock(
                            title: 'Height (cm)',
                            value: _height,
                            minValue: 130,
                            maxValue: 220,
                            onValueChanged: _updateHeight,
                            controller: FixedExtentScrollController(initialItem: _height - 130),
                          ),
                          const SizedBox(width: 16),
                          _buildSelectorBlock(
                            title: 'Weight (kg)',
                            value: _weight,
                            minValue: 30,
                            maxValue: 220,
                            onValueChanged: _updateWeight,
                            controller: FixedExtentScrollController(initialItem: _weight - 30),
                          ),
                          const SizedBox(width: 16),
                          _buildSelectorBlock(
                            title: 'Age',
                            value: _age,
                            minValue: 10,
                            maxValue: 100,
                            onValueChanged: _updateAge,
                            controller: FixedExtentScrollController(initialItem: _age - 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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
                              value: _isFemale,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 60.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('User selected values:');
                        print('Height: ${profile.height} cm');
                        print('Weight: ${profile.weight} kg');
                        print('Age: ${profile.age} years');
                        print('Gender: ${profile.isFemale ? 'Female' : 'Male'}');
                        context.read<OnboardingBloc>().add(UpdateUserProfile(
                          height: _height,
                          weight: _weight,
                          age: _age,
                          activityLevel: _activityLevel,
                          isFemale: _isFemale,
                        ));
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
      },
    );
  }

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
              height: 150,
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50,
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