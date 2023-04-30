part of 'user_bloc.dart';

class UserState {
  final List<Users> users;
  final List<Job> job;
  final bool isLoading;

  UserState(
      {this.users = const [], this.job = const [], this.isLoading = false});

  UserState copyWith(
      {List<Users>? users, List<Job>? job, bool isLoading = false}) {
    return UserState(
        users: users ?? this.users, job: job ?? this.job, isLoading: isLoading);
  }
}

class Users {
  final String name;
  final String id;
  Users({required this.name, required this.id});
}

class Job {
  final String name;
  final String id;
  Job({required this.name, required this.id});
}
