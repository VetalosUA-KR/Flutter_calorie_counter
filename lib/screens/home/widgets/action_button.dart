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
      child: Container(
        width: 60, // Размер кнопки (круглая)
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Круглая форма
          color: AppColors.getCardBackground(context) ,
        ),
        child: Icon(
          icon,
          color: AppColors.getIcon(context),
          size: 24, // Размер иконки
        ),
      ),
    );
  }
}