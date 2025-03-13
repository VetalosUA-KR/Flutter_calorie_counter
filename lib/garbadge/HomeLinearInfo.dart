import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../nutrition_profile.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  NutritionProfile? _nutritionProfile;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  // Заглушка для текущих потреблённых значений (можно заменить на реальные данные)
  Map<String, double> _consumedValues = {
    'calories': 0.0,
    'protein': 0.0,
    'fat': 0.0,
    'carbs': 0.0,
  };

  @override
  void initState() {
    super.initState();
    _setupAnimations(); // Инициализация анимаций перед загрузкой данных
    _loadNutritionProfile();
  }

  Future<void> _loadNutritionProfile() async {
    final box = Hive.box<NutritionProfile>('nutritionProfileBox');
    final nutrition = box.get('nutrition');
    if (nutrition != null) {
      setState(() {
        _nutritionProfile = nutrition;
        // Устанавливаем фиктивные данные потребления (50% от нормы)
        _consumedValues = {
          'calories': nutrition.calories * 0.5,
          'protein': nutrition.protein * 0.5,
          'fat': nutrition.fat * 0.5,
          'carbs': nutrition.carbs * 0.5,
        };
      });
      print('Nutrition Profile: $_nutritionProfile');
      // Запускаем анимацию после загрузки данных
      if (!_animationController.isAnimating && !_animationController.isCompleted) {
        _animationController.forward();
      }
    } else {
      print('No nutrition profile found.');
    }
  }

  void _setupAnimations() {
    // Инициализация контроллера анимации
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Анимация появления (fade-in)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Анимация смещения сверху вниз
    _slideAnimation = Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Анимация прогресс-бара (от 0 до текущего значения)
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Отступы по краям
          child: _nutritionProfile == null
              ? const Center(child: CircularProgressIndicator()) // Показываем индикатор загрузки
              : AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      Text(
                        'Your Daily Nutrition',
                        style: TextStyle(
                          fontSize: 28, // Размер шрифта заголовка
                          fontWeight: FontWeight.bold,
                          color: AppColors.getText(context),
                        ),
                      ),
                      const SizedBox(height: 20), // Отступ между заголовком и карточками
                      // Список показателей КБЖУ
                      Expanded(
                        child: ListView(
                          children: [
                            _buildNutritionCard(
                              title: 'Calories',
                              icon: Icons.local_fire_department,
                              goal: _nutritionProfile!.calories,
                              consumed: _consumedValues['calories']!,
                              unit: 'kcal',
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 16), // Отступ между карточками
                            _buildNutritionCard(
                              title: 'Protein',
                              icon: Icons.fitness_center,
                              goal: _nutritionProfile!.protein,
                              consumed: _consumedValues['protein']!,
                              unit: 'g',
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 16),
                            _buildNutritionCard(
                              title: 'Fat',
                              icon: Icons.local_dining,
                              goal: _nutritionProfile!.fat,
                              consumed: _consumedValues['fat']!,
                              unit: 'g',
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            _buildNutritionCard(
                              title: 'Carbs',
                              icon: Icons.bakery_dining,
                              goal: _nutritionProfile!.carbs,
                              consumed: _consumedValues['carbs']!,
                              unit: 'g',
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Виджет для отображения карточки показателя
  Widget _buildNutritionCard({
    required String title,
    required IconData icon,
    required double goal,
    required double consumed,
    required String unit,
    required Color color,
  }) {
    final progress = consumed / goal; // Процент выполнения
    final animatedProgress = progress * _progressAnimation.value; // Анимированное прогресс

    return Container(
      padding: const EdgeInsets.all(16.0), // Внутренние отступы карточки
      decoration: BoxDecoration(
        color: AppColors.getBackground(context).withOpacity(0.8),
        borderRadius: BorderRadius.circular(16), // Закругление углов карточки
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок карточки и иконка
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24, // Размер иконки
              ),
              const SizedBox(width: 8), // Отступ между иконкой и текстом
              Text(
                title,
                style: TextStyle(
                  fontSize: 18, // Размер шрифта заголовка карточки
                  fontWeight: FontWeight.bold,
                  color: AppColors.getText(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Отступ между заголовком и значениями
          // Значения (цель и потреблено)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goal: ${goal.toStringAsFixed(1)} $unit',
                style: TextStyle(
                  fontSize: 14, // Размер шрифта текста
                  color: AppColors.getText(context).withOpacity(0.7),
                ),
              ),
              Text(
                'Consumed: ${consumed.toStringAsFixed(1)} $unit',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.getText(context).withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Отступ перед прогресс-баром
          // Прогресс-бар
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Закругление прогресс-бара
            child: LinearProgressIndicator(
              value: animatedProgress.clamp(0.0, 1.0), // Анимированное значение прогресса
              backgroundColor: AppColors.getHint(context).withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8, // Высота прогресс-бара
            ),
          ),
          const SizedBox(height: 8), // Отступ после прогресс-бара
          // Процент выполнения
          Text(
            '${(progress * 100).toStringAsFixed(1)}% of daily goal',
            style: TextStyle(
              fontSize: 12, // Размер шрифта процента
              color: AppColors.getText(context).withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}