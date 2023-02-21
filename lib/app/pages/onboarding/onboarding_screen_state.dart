// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum OnboardingScreenStatus {
  initial,
  changed,
}

class OnboardingScreenState extends Equatable {
  final OnboardingScreenStatus status;
  final int currentPage;

  const OnboardingScreenState({
    required this.status,
    required this.currentPage,
  });

  const OnboardingScreenState.initial()
      : status = OnboardingScreenStatus.initial,
        currentPage = 0;

  @override
  List<Object?> get props => [status, currentPage];

  OnboardingScreenState copyWith({
    OnboardingScreenStatus? status,
    int? currentPage,
  }) {
    return OnboardingScreenState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
