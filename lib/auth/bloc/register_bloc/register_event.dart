part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  RegisterUsernameChanged(this.username);
}

class RegisterMobileChanged extends RegisterEvent {
  final String mobile;
  RegisterMobileChanged(this.mobile);
}

class RegisterSubmitted extends RegisterEvent {}
