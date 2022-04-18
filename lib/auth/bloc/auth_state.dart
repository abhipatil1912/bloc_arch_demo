part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateInit extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateFailed extends AuthState {
  final String errorMsg;
  AuthStateFailed(this.errorMsg);
}

class AuthStateSuccess extends AuthState {
  final RegisterModel registerModel;
  AuthStateSuccess(this.registerModel);
}
