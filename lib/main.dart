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
    CounterBloc bloc = CounterBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => bloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: Scaffold(
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            onPressed: () {
              bloc.add(CounterIncrementEvent());
            },
            icon: const Icon(Icons.plus_one),
          ),
          IconButton(
            onPressed: () {
              bloc.add(CounterDecrementEvent());
            },
            icon: const Icon(Icons.exposure_minus_1),
          ),
        ]),
        body: Center(
          child: BlocBuilder<CounterBloc, int>(
            builder: (context, state) {
              return Text(
                state.toString(),
                style: const TextStyle(fontSize: 55),
              );
            },
          ),
        ),
      ),
    );
  }
}
