import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_onIcrement);
    on<CounterDecrementEvent>(_onDecrement);
  }

  _onIcrement(CounterIncrementEvent event, Emitter<int> emitter) {
    emitter(state + 1);
  }

  _onDecrement(CounterDecrementEvent event, Emitter<int> emitter) {
    if (state <= 0) {
      return;
    }
    emitter(state - 1);
  }
}

abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}
