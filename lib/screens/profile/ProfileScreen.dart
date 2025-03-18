import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhelloworld/screens/profile/block/profile_block.dart';
import 'package:flutterhelloworld/screens/profile/block/profile_state.dart';
import 'block/profile_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 вкладки
    context.read<ProfileBlock>().add(LoadDailyStatsEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Meals'), // Вкладка для приемов пищи
            Tab(text: 'Activities'), // Вкладка для активностей
          ],
        ),
      ),
      body: BlocBuilder<ProfileBlock, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.dailyStats == null || state.dailyStats!.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // Вкладка "Приемы пищи"
              _buildMealsTab(state),
              // Вкладка "Активности"
              _buildActivitiesTab(state),
            ],
          );
        },
      ),
    );
  }

  // Виджет для вкладки "Приемы пищи"
  Widget _buildMealsTab(ProfileState state) {
    return ListView.builder(
      itemCount: state.dailyStats!.length,
      itemBuilder: (context, index) {
        final dailyStat = state.dailyStats![index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: Text('Date: ${dailyStat.date.toLocal()}'),
            children: [
              ...dailyStat.mealsByType.entries.map((entry) {
                final mealType = entry.key;
                final meals = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Meal Type: ${mealType.toString().split('.').last}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ...meals.map((meal) {
                      return ListTile(
                        title: Text(meal.name),
                        subtitle: Text(
                          'Calories: ${meal.calories}, Protein: ${meal.protein}, Fat: ${meal.fat}, Carbs: ${meal.carbs}',
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  // Виджет для вкладки "Активности"
  Widget _buildActivitiesTab(ProfileState state) {
    return ListView.builder(
      itemCount: state.dailyStats!.length,
      itemBuilder: (context, index) {
        final dailyStat = state.dailyStats![index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: Text('Date: ${dailyStat.date.toLocal()}'),
            children: [
              if (dailyStat.activities.isNotEmpty)
                ...dailyStat.activities.map((activity) {
                  return ListTile(
                    title: Text(activity.type),
                    subtitle: Text(
                      'Duration: ${activity.duration} min, '
                          'Burned Calories: ${activity.burnedCalories} kcal, '
                          'Intensity: ${activity.intensity}',
                    ),
                  );
                }).toList()
              else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No activities for this day.'),
                ),
            ],
          ),
        );
      },
    );
  }
}