import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../data/repo/auth_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterMobileChanged>(_onMobileChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Name.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.mobile, username]),
    ));
  }

  void _onMobileChanged(
    RegisterMobileChanged event,
    Emitter<RegisterState> emit,
  ) {
    final mobile = Mobile.dirty(event.mobile);
    emit(state.copyWith(
      mobile: mobile,
      status: Formz.validate([mobile, state.username]),
    ));
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final failOrSuccess = await RegisterRepo.register(
          mobile: state.mobile.value,
          name: state.username.value,
        );
        failOrSuccess.fold(
          //? fail
          (errorMsg) =>
              emit(state.copyWith(status: FormzStatus.submissionFailure)),
          //? success
          (model) {
            emit(state.copyWith(status: FormzStatus.submissionSuccess));
          },
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
