import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/users_model.dart';
import '../../data/repo/home_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {
    on<UserEventFetch>(_onUserFetch);
  }

  //? on user fetch event
  Future<void> _onUserFetch(
    UserEventFetch event,
    Emitter<UserState> emit,
  ) async {
    //? fetch users
    final failOrSuccess = await HomeRepo.getUsers();
    failOrSuccess.fold(
      (errorMsg) => emit(UserStateFailed(errorMsg)),
      (users) => emit(UserStateSuccess(users)),
    );
  }
}
