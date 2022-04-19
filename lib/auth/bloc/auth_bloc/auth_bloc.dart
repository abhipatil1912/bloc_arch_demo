import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../register_bloc/register_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterBloc registerBloc;
  late final StreamSubscription registerBlocSubscription;
  AuthBloc(
    this.registerBloc,
  ) : super(AuthState.unknown) {
    registerBlocSubscription = registerBloc.stream.listen((state) {
      if (state.status == FormzStatus.submissionSuccess) {
        emit(AuthState.authenticated);
      }
    });
    on<AuthStateChanged>(_onAuthStateChange);
  }
}

void _onAuthStateChange(
  AuthStateChanged event,
  Emitter<AuthState> emit,
) async {
  emit(event.status);
}
