part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserStateInitial extends UserState {}

class UserStateFailed extends UserState {
  final String errorMsg;
  UserStateFailed(this.errorMsg);
}

class UserStateSuccess extends UserState {
  final List<User> users;
  UserStateSuccess(this.users);
}
