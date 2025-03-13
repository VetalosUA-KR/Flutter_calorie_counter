// lib/screens/home/widgets/macro_card.dart
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class MacroCard extends StatelessWidget {
  final String title;
  final double goal;
  final double consumed;
  final String unit;
  final Color color;
  final double animatedProgress;

  const MacroCard({
    super.key,
    required this.title,
    required this.goal,
    required this.consumed,
    required this.unit,
    required this.color,
    required this.animatedProgress,
  });

  @override
  Widget build(BuildContext context) {
    // Выбор иконки в зависимости от заголовка
    IconData getIconForTitle(String title) {
      switch (title.toLowerCase()) {
        case 'protein':
          return Icons.fitness_center;
        case 'fat':
          return Icons.fastfood;
        case 'carbs':
          return Icons.bakery_dining_rounded;
        default:
          return Icons.circle; // Значение по умолчанию
      }
    }

    return Container(
      padding: const EdgeInsets.all(8.0), // Внутренние отступы карточки
      decoration: BoxDecoration(
        color: AppColors.getCardBackground(context).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12), // Закругление углов карточки
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
          // Строка с заголовком и иконкой
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Разделяем заголовок и иконку
            children: [
              // Название макронутриента
              Text(
                title,
                style: TextStyle(
                  fontSize: 16, // Размер шрифта заголовка
                  fontWeight: FontWeight.bold,
                  color: AppColors.getText(context),
                ),
              ),
              // Иконка в правом верхнем углу
              Icon(
                getIconForTitle(title),
                color: color, // Цвет иконки соответствует цвету прогресс-бара
                size: 20, // Размер иконки
              ),
            ],
          ),
          // Отступ между заголовком и значениями
          const SizedBox(height: 8),
          // Значения (цель и потреблено)
          Text(
            '${consumed.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} $unit',
            style: TextStyle(
              fontSize: 14, // Размер шрифта текста
              color: AppColors.getText(context).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8), // Отступ перед прогресс-баром
          // Прогресс-бар
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Закругление прогресс-бара
            child: LinearProgressIndicator(
              value: animatedProgress.clamp(0.0, 1.0), // Анимированное значение прогресса
              backgroundColor: AppColors.getHint(context).withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6, // Высота прогресс-бара
            ),
          ),
        ],
      ),
    );
  }
}