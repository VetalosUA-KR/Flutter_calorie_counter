import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../block/onboarding_bloc.dart';
import 'package:flutterhelloworld/user_profile.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  double _selectedActivityLevel = 1.375; // Начальное значение (лёгкая активность)

  // Список уровней активности
  final List<Map<String, dynamic>> _activityLevels = [
    {
      'level': 1.2,
      'title': 'Minimal Activity',
      'description': 'Sedentary lifestyle, little to no exercise.',
    },
    {
      'level': 1.375,
      'title': 'Light Activity',
      'description': 'Light exercise/sports 1–3 days per week.',
    },
    {
      'level': 1.55,
      'title': 'Moderate Activity',
      'description': 'Moderate exercise/sports 3–5 days per week.',
    },
    {
      'level': 1.725,
      'title': 'High Activity',
      'description': 'Hard exercise/sports 6–7 days per week.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Загружаем данные из BLoC и устанавливаем начальный уровень активности
    final profile = context.read<OnboardingBloc>().state is OnboardingLoaded
        ? (context.read<OnboardingBloc>().state as OnboardingLoaded).profile
        : null;
    if (profile != null && profile.activityLevel != 0) {
      _selectedActivityLevel = profile.activityLevel;
    }
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
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.getText(context)),
                onPressed: () {
                  context.go('/onboarding1');
                },
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Горизонтальные отступы для всего содержимого
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Заголовок
                          Text(
                            'Activity Level',
                            style: TextStyle(
                              fontSize: 28, // Размер шрифта заголовка
                              fontWeight: FontWeight.bold,
                              color: AppColors.getText(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10), // Отступ между заголовком и подзаголовком
                          // Подзаголовок
                          Text(
                            'Select your activity level to calculate your daily needs.',
                            style: TextStyle(
                              fontSize: 16, // Размер шрифта подзаголовка
                              color: AppColors.getText(context).withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30), // Отступ между подзаголовком и списком
                          // Список уровней активности
                          SizedBox(
                            height: constraints.maxHeight * 0.6, // Высота ListView (60% от доступной высоты экрана)
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: _activityLevels.length,
                              itemBuilder: (context, index) {
                                final activity = _activityLevels[index];
                                final isSelected = _selectedActivityLevel == activity['level'];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0), // Отступ снизу для каждой карточки
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedActivityLevel = activity['level'];
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300), // Длительность анимации при выборе
                                      curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.getPrimary(context).withOpacity(0.1)
                                            : AppColors.getBackground(context),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.getPrimary(context)
                                              : AppColors.getText(context).withOpacity(0.3),
                                          width: 2, // Толщина границы карточки
                                        ),
                                        borderRadius: BorderRadius.circular(12), // Закругление углов карточки
                                      ),
                                      padding: const EdgeInsets.all(12.0), // Внутренние отступы карточки
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Иконка слева
                                          Icon(
                                            Icons.directions_run,
                                            color: isSelected
                                                ? AppColors.getPrimary(context)
                                                : AppColors.getText(context).withOpacity(0.7),
                                          ),
                                          const SizedBox(width: 16), // Отступ между иконкой и текстом
                                          // Текстовая часть (название и описание)
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Название уровня активности
                                                Text(
                                                  activity['title'],
                                                  style: TextStyle(
                                                    fontSize: 18, // Размер шрифта названия
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.getText(context),
                                                  ),
                                                ),
                                                const SizedBox(height: 4), // Отступ между названием и описанием
                                                // Описание уровня активности с ограниченной шириной
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.65, // Ширина текста описания (55% ширины экрана)
                                                  child: Text(
                                                    activity['description'],
                                                    style: TextStyle(
                                                      fontSize: 14, // Размер шрифта описания
                                                      color: AppColors.getText(context).withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8), // Зарезервированное место для иконки галочки
                                          // Иконка галочки при выборе
                                          if (isSelected)
                                            Icon(
                                              Icons.check_circle,
                                              color: AppColors.getPrimary(context),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 40), // Отступ между списком и кнопкой
                          // Кнопка "Finish"
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0), // Отступ снизу для кнопки
                            child: ElevatedButton(
                              onPressed: () {
                                // Обновляем профиль с выбранным уровнем активности
                                context.read<OnboardingBloc>().add(UpdateUserProfile(
                                  height: profile.height,
                                  weight: profile.weight,
                                  age: profile.age,
                                  activityLevel: _selectedActivityLevel,
                                  isFemale: profile.isFemale,
                                ));
                                context.go('/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.getPrimary(context),
                                padding: const EdgeInsets.symmetric(vertical: 16), // Внутренние отступы кнопки (высота кнопки)
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // Закругление углов кнопки
                                ),
                              ),
                              child: const Text(
                                'Finish',
                                style: TextStyle(
                                  fontSize: 18, // Размер шрифта текста кнопки
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}