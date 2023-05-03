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
    CounterBloc counterBloc = CounterBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserBloc(counterBloc),
        ),
      ],
      child: const MaterialApp(
        home: FirstPage(),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          onPressed: () {
            counterBloc.add(CounterIncrementEvent());
          },
          icon: const Icon(Icons.plus_one),
        ),
        IconButton(
          onPressed: () {
            counterBloc.add(CounterDecrementEvent());
          },
          icon: const Icon(Icons.exposure_minus_1),
        ),
        IconButton(
          onPressed: () {
            UserBloc userBloc = context.read<UserBloc>();
            userBloc.add(UserGetUsersEvent(context.read<CounterBloc>().state));
          },
          icon: const Icon(Icons.person),
        ),
        IconButton(
          onPressed: () {
            UserBloc userBloc = context.read<UserBloc>();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Job()),
            );
            userBloc
                .add(UserGetUsersJobEvent(context.read<CounterBloc>().state));
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
                  final users =
                      context.select((UserBloc bloc) => bloc.state.users);
                  return Column(
                    children: [
                      Text(
                        state.toString(),
                        style: const TextStyle(fontSize: 55),
                      ),
                      if (users.isNotEmpty) ...users.map((e) => Text(e.name)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Job extends StatelessWidget {
  const Job({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final job = state.job;
          return Column(
            children: [
              if (state.isLoading) const CircularProgressIndicator(),
              if (job.isNotEmpty) ...job.map((e) => Text(e.name)),
            ],
          );
        },
      ),
    );
  }
}
