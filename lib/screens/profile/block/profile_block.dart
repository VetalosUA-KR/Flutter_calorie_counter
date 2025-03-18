import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterhelloworld/screens/profile/block/profile_event.dart';
import 'package:flutterhelloworld/screens/profile/block/profile_state.dart';
import 'package:flutterhelloworld/repository/stats_repository.dart';

class ProfileBlock extends Bloc<ProfileEvent, ProfileState> {
  final StatsRepository statsRepository;

  ProfileBlock({required this.statsRepository}) : super(const ProfileState()) {
    on<LoadDailyStatsEvent>(_onLoadDailyStatsEvent);
    on<UpdateDailyStatsEvent>(_onUpdateDailyStatsEvent); // Добавьте этот обработчик
  }

  Future<void> _onLoadDailyStatsEvent(
      LoadDailyStatsEvent event, Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final stats = statsRepository.getAllStats();
      emit(state.copyWith(dailyStats: stats, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onUpdateDailyStatsEvent(
      UpdateDailyStatsEvent event, Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final stats = statsRepository.getAllStats();
      emit(state.copyWith(dailyStats: stats, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}