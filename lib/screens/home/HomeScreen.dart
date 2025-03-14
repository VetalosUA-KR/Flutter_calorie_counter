// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/app_colors.dart';
import 'package:flutterhelloworld/screens/home/block/home_bloc.dart';
import 'package:flutterhelloworld/screens/home/block/home_event.dart';
import 'package:flutterhelloworld/screens/home/block/home_state.dart';
import 'widgets/action_button.dart';
import 'widgets/circular_progress_painter.dart';
import 'widgets/macro_card.dart';
import 'widgets/add_meal_bottom_sheet.dart';
import 'package:flutterhelloworld/model/meal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // Инициализация BLoC и запуск события загрузки
    context.read<HomeBloc>().add(LoadNutritionProfileEvent());
  }

  void _setupAnimations() {
    // Инициализация контроллера анимации
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    // Анимация появления (fade-in)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Анимация смещения сверху вниз
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _showAddMealBottomSheet() {
    final homeBloc = context.read<HomeBloc>(); // Получаем HomeBloc до открытия BottomSheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Для корректного отображения с клавиатурой
      builder: (context) {
        return AddMealBottomSheet(
          mealType: MealType.breakfast,
          onAddMeal: (Meal meal) {
            // Добавляем приём пищи через BLoC
            //context.read<HomeBloc>().add(AddMealEvent(meal));
            homeBloc.add(AddMealEvent(meal));
          },
        );
      },
    );
  }

  /*void _showAddMealBottomSheet() {
    final homeBloc = context.read<HomeBloc>(); // Получаем HomeBloc до открытия BottomSheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Meal Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MealType>(
                value: MealType.breakfast,
                decoration: InputDecoration(
                  labelText: 'Meal Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: MealType.values.map((MealType type) {
                  return DropdownMenuItem<MealType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (MealType? newValue) {
                  if (newValue != null) {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddMealBottomSheet(
                        onAddMeal: (Meal meal) {
                          homeBloc.add(AddMealEvent(meal)); // Используем переданный HomeBloc
                        },
                        mealType: newValue,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }*/

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Динамический размер прогресс-бара в зависимости от ширины экрана
    final progressBarSize =
        MediaQuery.of(context).size.width * 0.5; // 50% от ширины экрана

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.getBackground(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ), // Отступы по краям
              child:
                  state.nutritionProfile == null
                      ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Показываем индикатор загрузки
                      : FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Заголовок
                              Text(
                                'Daily Progress',
                                style: TextStyle(
                                  fontSize: 22, // Размер шрифта заголовка
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.getText(context),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Отступ между заголовком и прогрессом
                              // Горизонтальная линия с кнопками и прогресс-баром
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Кнопка "Add Food" слева
                                  ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 0.5,
                                      end: 1.0,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.elasticOut,
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Tooltip(
                                        message: 'Add Food',
                                        child: ActionButton(
                                          icon: Icons.fastfood,
                                          onTap: _showAddMealBottomSheet,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Кастомный круглый прогресс-бар для калорий
                                  SizedBox(
                                    width: progressBarSize, // Адаптивный размер
                                    height: progressBarSize,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Кастомный прогресс-бар
                                        CustomPaint(
                                          painter: CircularProgressPainter(
                                            progress:
                                                (state.consumedValues['calories']! /
                                                    state
                                                        .nutritionProfile!
                                                        .calories) *
                                                state.progressAnimationValue,
                                            backgroundColor: AppColors.getHint(
                                              context,
                                            ).withOpacity(0.2),
                                            progressColor: Colors.orange,
                                            strokeWidth: 10, // Толщина кольца
                                          ),
                                          child: SizedBox(
                                            width: progressBarSize,
                                            height: progressBarSize,
                                          ),
                                        ),
                                        // Текст внутри круга
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Calories',
                                              style: TextStyle(
                                                fontSize:
                                                    progressBarSize * 0.07,
                                                // Адаптивный размер шрифта
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.getText(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            // Отступ между заголовком и значениями
                                            Text(
                                              '${state.consumedValues['calories']!.toStringAsFixed(0)} / ${state.nutritionProfile!.calories.toStringAsFixed(0)} kcal',
                                              style: TextStyle(
                                                fontSize:
                                                    progressBarSize * 0.06,
                                                // Адаптивный размер шрифта
                                                color: AppColors.getText(
                                                  context,
                                                ).withOpacity(0.7),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Кнопка "Add Activity" справа
                                  ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 0.5,
                                      end: 1.0,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.elasticOut,
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Tooltip(
                                        message: 'Add Activity',
                                        child: ActionButton(
                                          icon: Icons.directions_run,
                                          onTap: () {
                                            print(
                                              'Add Activity pressed (placeholder)',
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Отступ перед макронутриентами
                              // Блок макронутриентов
                              Text(
                                'Macronutrients',
                                style: TextStyle(
                                  fontSize: 20, // Размер шрифта заголовка
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.getText(context),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Отступ между заголовком и макронутриентами
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                            48) /
                                        3,
                                    // Фиксированная ширина карточки
                                    child: MacroCard(
                                      title: 'Protein',
                                      goal: state.nutritionProfile!.protein,
                                      consumed:
                                          state.consumedValues['protein']!,
                                      unit: 'g',
                                      color: Colors.blue,
                                      animatedProgress:
                                          (state.consumedValues['protein']! /
                                              state.nutritionProfile!.protein) *
                                          state.progressAnimationValue,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                            48) /
                                        3,
                                    // Фиксированная ширина карточки
                                    child: MacroCard(
                                      title: 'Fat',
                                      goal: state.nutritionProfile!.fat,
                                      consumed: state.consumedValues['fat']!,
                                      unit: 'g',
                                      color: Colors.red,
                                      animatedProgress:
                                          (state.consumedValues['fat']! /
                                              state.nutritionProfile!.fat) *
                                          state.progressAnimationValue,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                            48) /
                                        3,
                                    // Фиксированная ширина карточки
                                    child: MacroCard(
                                      title: 'Carbs',
                                      goal: state.nutritionProfile!.carbs,
                                      consumed: state.consumedValues['carbs']!,
                                      unit: 'g',
                                      color: Colors.green,
                                      animatedProgress:
                                          (state.consumedValues['carbs']! /
                                              state.nutritionProfile!.carbs) *
                                          state.progressAnimationValue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}
