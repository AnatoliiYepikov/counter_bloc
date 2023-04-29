import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserGetUsersEvent>(_onGetUser);
  }

  _onGetUser(UserGetUsersEvent event, Emitter<UserState> state) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
