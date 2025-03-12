import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_colors.dart';
import '../theme/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                // Определяем текущую фактическую тему через Theme.of(context).brightness
                final isCurrentlyDark = Theme.of(context).brightness == Brightness.dark;

                return Column(
                  children: [
                    Text(
                      'Current Theme: ${isCurrentlyDark ? 'Dark' : 'Light'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.getText(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Light'),
                        Switch(
                          value: state.isDarkMode,
                          onChanged: (value) {
                            context.read<ThemeBloc>().add(ThemeChanged(value));
                          },
                          activeColor: AppColors.getPrimary(context),
                        ),
                        const Text('Dark'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}