part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthStateChanged extends AuthEvent {
  final AuthState status;
  AuthStateChanged(this.status);
}
