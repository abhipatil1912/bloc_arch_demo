part of 'auth_bloc.dart';

abstract class AuthEvent {}

// class AuthUsernameChanged extends AuthEvent {
//   final String username;
//   AuthUsernameChanged(this.username);
// }

// class AuthMobileChanged extends AuthEvent {
//   final String password;
//   AuthMobileChanged(this.password);
// }

class AuthSubmitted extends AuthEvent {
  final String userName;
  final String mobile;
  AuthSubmitted({required this.userName, required this.mobile});
}
