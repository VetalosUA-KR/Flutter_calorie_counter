// lib/screens/home/widgets/action_button.dart
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Длительность анимации нажатия
        transform: Matrix4.identity()..scale(0.95), // Эффект уменьшения при нажатии
        child: Container(
          width: 50, // Размер кнопки (круглая)
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Круглая форма
            gradient: LinearGradient(
              colors: [
                AppColors.getPrimary(context).withOpacity(0.2),
                AppColors.getPrimary(context).withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.getPrimary(context),
            size: 24, // Размер иконки
          ),
        ),
      ),
    );
  }
}