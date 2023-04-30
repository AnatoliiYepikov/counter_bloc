part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetUsersEvent extends UserEvent {
  final int counter;

  UserGetUsersEvent(this.counter);
}

class UserGetUsersJobEvent extends UserEvent {
  final int counter;

  UserGetUsersJobEvent(this.counter);
}
