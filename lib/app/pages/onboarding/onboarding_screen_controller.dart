import 'package:a_de_adote/app/pages/onboarding/onboarding_screen_state.dart';
import 'package:bloc/bloc.dart';

class OnboardingScreenController extends Cubit<OnboardingScreenState> {
  OnboardingScreenController() : super(const OnboardingScreenState.initial());

  void setPage(int page) {
    emit(
      state.copyWith(
        status: OnboardingScreenStatus.changed,
        currentPage: page,
      ),
    );
  }
}
