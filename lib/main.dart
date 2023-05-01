import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';
import 'package:counter_bloc/bloc/user_bloc.dart';

void main() {
  runApp(const MyCounterBloc());
}

class MyCounterBloc extends StatelessWidget {
  const MyCounterBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          floatingActionButton:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              onPressed: () {
                CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
                counterBloc.add(CounterIncrementEvent());
              },
              icon: const Icon(Icons.plus_one),
            ),
            IconButton(
              onPressed: () {
                //counterBloc.add(CounterDecrementEvent());
              },
              icon: const Icon(Icons.exposure_minus_1),
            ),
            IconButton(
              onPressed: () {
                //userBloc.add(UserGetUsersEvent(counterBloc.state));
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                //userBloc.add(UserGetUsersJobEvent(counterBloc.state));
              },
              icon: const Icon(Icons.work),
            ),
          ]),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  BlocBuilder<CounterBloc, int>(
                    //bloc: counterBloc,
                    builder: (context, state) {
                      return Text(
                        state.toString(),
                        style: const TextStyle(fontSize: 55),
                      );
                    },
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    //bloc: userBloc,
                    builder: (context, state) {
                      final users = state.users;
                      final job = state.job;
                      return Column(
                        children: [
                          if (state.isLoading)
                            const CircularProgressIndicator(),
                          if (users.isNotEmpty)
                            ...users.map((e) => Text(e.name)),
                          if (job.isNotEmpty) ...job.map((e) => Text(e.name)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
