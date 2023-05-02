import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter_bloc/counter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocSubscription;
  UserBloc(this.counterBloc) : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUserJob);
    counterBlocSubscription = counterBloc.stream.listen((state) {
      if (state <= 0) {
        add(UserGetUsersEvent(0));
        add(UserGetUsersJobEvent(0));
      }
    });
    @override
    Future<void> close() async {
      counterBlocSubscription.cancel();
      return super.close();
    }
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
