import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../block/onboarding_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = (state as OnboardingLoaded).profile;

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Height: ${profile.height} cm'),
                      Text('Weight: ${profile.weight} kg'),
                      Text('Age: ${profile.age} years'),
                      Text('Gender: ${profile.isFemale ? 'Female' : 'Male'}'),
                      Text('Activity level: ${profile.activityLevel}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}