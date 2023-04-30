import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUserJob);
  }

  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    List<Users> users = List.generate(event.counter, (index) {
      return Users(name: 'user name', id: index.toString());
    });
    emit(state.copyWith(users: users));
  }

  _onGetUserJob(UserGetUsersJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    List<Job> job = List.generate(event.counter, (index) {
      return Job(name: 'job name', id: index.toString());
    });
    emit(state.copyWith(job: job));
  }
}
