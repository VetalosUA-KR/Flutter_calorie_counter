import 'package:flutter/material.dart';

class AppColors {
  // Цвета для светлой темы
  static const Color lightPrimary = Color(0xFF75A9B0); // Основной цвет
  static const Color lightBackground = Color(0xFFFFFFFF); // Фон
  static const Color lightText = Color(0xFF000000); // Текст
  static const Color lightTextSubtitle = Color(0xFF838383); // Текст
  static const Color lightAppBar = Color(0xFF37818D); // AppBar
  static const Color lightSnackBar = Color(0xFF333333); // SnackBar
  static const Color lightHint = Color(0xFF757575); // Подсказки
  static const Color lightCardBackground = Color(0x80ADDBE3); // фон карточки

  // Цвета для тёмной темы
  static const Color darkPrimary = Color(0xFF2B5E28); // Основной цвет
  static const Color darkBackground = Color(0xFF121212); // Фон
  static const Color darkText = Color(0xFFFFFFFF); // Текст
  static const Color darkTextSubtitle = Color(0xFF6C6C6C); // Текст
  static const Color darkAppBar = Color(0xFF1F441D); // AppBar
  static const Color darkSnackBar = Color(0xFF424242); // SnackBar
  static const Color darkHint = Color(0xFFB0BEC5); // Подсказки
  static const Color darkCardBackground = Color(0x80567054); // фон карточки

  // Метод для получения цветов в зависимости от темы
  static Color getCardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightCardBackground : darkCardBackground;
  static Color getPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightPrimary : darkPrimary;

  static Color getBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightBackground : darkBackground;

  static Color getText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightText : darkText;

  static Color getTextSubtitle(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightTextSubtitle : darkTextSubtitle;

  static Color getAppBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightAppBar : darkAppBar;

  static Color getSnackBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightSnackBar : darkSnackBar;

  static Color getHint(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightHint : darkHint;
}