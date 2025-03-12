import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../block/onboarding_bloc.dart';
import 'package:flutterhelloworld/user_profile.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  void initState() {
    super.initState();
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
              elevation: 0,
              backgroundColor: AppColors.getBackground(context),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => context.go('/onboarding2'),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: AppColors.getTextSubtitle(context)),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Let’s Get Started!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getText(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSelectorBlock(
                            title: 'Height (cm)',
                            value: profile.height,
                            minValue: 130,
                            maxValue: 220,
                            onValueChanged: (value) => context.read<OnboardingBloc>().add(UpdateUserProfile(
                              height: value,
                              weight: profile.weight,
                              age: profile.age,
                              isFemale: profile.isFemale,
                            )),
                            controller: FixedExtentScrollController(initialItem: profile.height - 130),
                          ),
                          const SizedBox(width: 16),
                          _buildSelectorBlock(
                            title: 'Weight (kg)',
                            value: profile.weight,
                            minValue: 30,
                            maxValue: 220,
                            onValueChanged: (value) => context.read<OnboardingBloc>().add(UpdateUserProfile(
                              height: profile.height,
                              weight: value,
                              age: profile.age,
                              isFemale: profile.isFemale,
                            )),
                            controller: FixedExtentScrollController(initialItem: profile.weight - 30),
                          ),
                          const SizedBox(width: 16),
                          _buildSelectorBlock(
                            title: 'Age',
                            value: profile.age,
                            minValue: 10,
                            maxValue: 100,
                            onValueChanged: (value) => context.read<OnboardingBloc>().add(UpdateUserProfile(
                              height: profile.height,
                              weight: profile.weight,
                              age: value,
                              isFemale: profile.isFemale,
                            )),
                            controller: FixedExtentScrollController(initialItem: profile.age - 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.getText(context).withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Male'),
                            Switch(
                              value: profile.isFemale,
                              onChanged: (value) => context.read<OnboardingBloc>().add(UpdateUserProfile(
                                height: profile.height,
                                weight: profile.weight,
                                age: profile.age,
                                isFemale: value,
                              )),
                              activeColor: AppColors.getPrimary(context),
                              activeTrackColor: AppColors.getPrimary(context).withOpacity(0.5),
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.withOpacity(0.5),
                            ),
                            const Text('Female'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 60.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('User selected values:');
                        print('Height: ${profile.height} cm');
                        print('Weight: ${profile.weight} kg');
                        print('Age: ${profile.age} years');
                        print('Gender: ${profile.isFemale ? 'Female' : 'Male'}');
                        context.go('/onboarding2');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.getPrimary(context),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectorBlock({
    required String title,
    required int value,
    required int minValue,
    required int maxValue,
    required Function(int) onValueChanged,
    required FixedExtentScrollController controller,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.getText(context).withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.getText(context).withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              height: 150,
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.4,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  final newValue = minValue + index;
                  onValueChanged(newValue);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: maxValue - minValue + 1,
                  builder: (context, index) {
                    final displayValue = minValue + index;
                    final isSelected = displayValue == value;
                    return Center(
                      child: Text(
                        '$displayValue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? AppColors.getText(context)
                              : AppColors.getTextSubtitle(context),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}