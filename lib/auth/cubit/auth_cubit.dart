import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //? init
  AuthCubit() : super(AuthStateInit());

  //? register
  void register(String name, String mobile) async {
    //? emitting loading state
    emit(AuthStateLoading());

    //? register request
    final failOrSuccess = await AuthRepo.register(name, mobile);
    failOrSuccess.fold(
      //? fail
      (errorMsg) => emit(AuthStateFailed(errorMsg)),
      //? success
      (model) => emit(AuthStateSuccess(model)),
    );
  }
}
