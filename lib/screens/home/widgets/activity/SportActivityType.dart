enum SportActivityType {
  running('Бег', 10.0), // ~10 ккал/мин
  cycling('Велосипед', 8.0), // ~8 ккал/мин
  swimming('Плавание', 7.0), // ~7 ккал/мин
  walking('Ходьба', 4.0), // ~4 ккал/мин
  gym('Тренажерный зал', 6.0), // ~6 ккал/мин
  yoga('Йога', 3.0), // ~3 ккал/мин
  basketball('Баскетбол', 8.5), // ~8.5 ккал/мин
  football('Футбол', 9.0), // ~9 ккал/мин
  tennis('Теннис', 7.5), // ~7.5 ккал/мин
  other('Другое', 5.0); // ~5 ккал/мин (среднее значение)

  final String displayName; // Строковое значение для отображения и сохранения
  final double caloriesPerMinute; // Количество калорий, сжигаемых за минуту

  const SportActivityType(this.displayName, this.caloriesPerMinute);

  @override
  String toString() => displayName; // Переопределяем toString для удобства
}