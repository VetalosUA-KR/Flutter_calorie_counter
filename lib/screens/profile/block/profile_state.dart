import 'package:equatable/equatable.dart';
import 'package:flutterhelloworld/model/daily_stats.dart';

class ProfileState extends Equatable {
  final List<DailyStats>? dailyStats;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.dailyStats,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    List<DailyStats>? dailyStats,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      dailyStats: dailyStats ?? this.dailyStats,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [dailyStats, isLoading, error];
}