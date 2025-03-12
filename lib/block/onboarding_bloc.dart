import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/user_profile_repository.dart';
import 'package:flutterhelloworld/user_profile.dart';

/*part 'onboarding_event.dart';
part 'onboarding_state.dart';*/

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UserProfileRepository repository;

  OnboardingBloc({required this.repository}) : super(OnboardingInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<OnboardingState> emit) async {
    final profile = repository.getProfile();
    emit(OnboardingLoaded(profile: profile));
  }

  Future<void> _onUpdateUserProfile(UpdateUserProfile event, Emitter<OnboardingState> emit) async {
    final updatedProfile = UserProfile(
      height: event.height,
      weight: event.weight,
      age: event.age,
      isFemale: event.isFemale,
    );
    await repository.saveProfile(updatedProfile);
    emit(OnboardingLoaded(profile: updatedProfile));
  }
}

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends OnboardingEvent {}

class UpdateUserProfile extends OnboardingEvent {
  final int height;
  final int weight;
  final int age;
  final bool isFemale;

  const UpdateUserProfile({
    required this.height,
    required this.weight,
    required this.age,
    required this.isFemale,
  });

  @override
  List<Object?> get props => [height, weight, age, isFemale];
}

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final UserProfile profile;

  const OnboardingLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}