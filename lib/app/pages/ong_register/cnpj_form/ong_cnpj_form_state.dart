import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../../models/ong_model.dart';

part 'ong_cnpj_form_state.g.dart';

@match
enum OngCnpjFormStatus {
  inital,
  loading,
  loaded,
  error,
}

class OngCnpjFormState extends Equatable {
  final OngCnpjFormStatus status;
  final OngModel? ong;
  final String? errorMessage;

  const OngCnpjFormState({
    required this.status,
    required this.ong,
    this.errorMessage,
  });

  const OngCnpjFormState.initial()
      : status = OngCnpjFormStatus.inital,
        ong = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, ong, errorMessage];

  OngCnpjFormState copyWith({
    OngCnpjFormStatus? status,
    OngModel? ong,
    String? errorMessage,
  }) {
    return OngCnpjFormState(
      status: status ?? this.status,
      ong: ong ?? this.ong,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
