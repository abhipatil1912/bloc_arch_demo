import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/register_model.dart';
import '../data/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInit()) {
    // on<AuthUsernameChanged>(_onUsernameChanged);
    // on<AuthMobileChanged>(_onMobileChanged);
    on<AuthSubmitted>(_onSubmitted);
  }
}

// void _onUsernameChanged(
//   AuthUsernameChanged event,
//   Emitter<AuthState> emit,
// ) {}

// void _onMobileChanged(
//   AuthMobileChanged event,
//   Emitter<AuthState> emit,
// ) {}

void _onSubmitted(
  AuthSubmitted event,
  Emitter<AuthState> emit,
) async {
  //? emitting loading state
  emit(AuthStateLoading());

  //? register request
  final failOrSuccess = await AuthRepo.register(event.userName, event.mobile);
  failOrSuccess.fold(
    //? fail
    (errorMsg) => emit(AuthStateFailed(errorMsg)),
    //? success
    (model) => emit(AuthStateSuccess(model)),
  );
}
