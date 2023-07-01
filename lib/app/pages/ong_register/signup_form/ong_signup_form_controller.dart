import 'package:a_de_adote/app/core/exceptions/firestore_exception.dart';
import 'package:a_de_adote/app/core/exceptions/http_request_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../models/ong_model.dart';
import 'ong_signup_form_state.dart';

class OngSignupFormController extends Cubit<OngSignupFormState> {
  final AuthService _authService;
  final OngRepository _ongRepository;

  OngSignupFormController(
    this._authService,
    this._ongRepository,
  ) : super(const OngSignupFormState.initial());

  Future<void> signUpOng(OngModel ong, String password) async {
    try {
      emit(state.copyWith(status: OngSignupFormStatus.loading));
      await _authService.signUp(email: ong.email, password: password);
      final ongModel = ong.copyWith(id: _authService.ongUser?.uid);
      await _ongRepository.createOng(ongModel);
      emit(state.copyWith(status: OngSignupFormStatus.userCreated));
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: OngSignupFormStatus.error,
          errorMessage: e.message,
        ),
      );
    } on FirestoreException catch (e) {
      await _authService.ongUser?.delete();
      emit(
        state.copyWith(
          status: OngSignupFormStatus.error,
          errorMessage: e.message,
        ),
      );
    } on HttpRequestException catch (e) {
      await _ongRepository.deleteOng(_authService.ongUser?.uid);
      await _authService.ongUser?.delete();
      emit(
        state.copyWith(
          status: OngSignupFormStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
