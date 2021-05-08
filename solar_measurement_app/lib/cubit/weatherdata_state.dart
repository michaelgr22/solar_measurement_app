part of 'weatherdata_cubit.dart';

@immutable
abstract class WeatherdataState {
  const WeatherdataState();
}

class WeatherdataInitial extends WeatherdataState {}

class WeatherdataStateInitial extends WeatherdataState {
  const WeatherdataStateInitial();
}

class WeatherdataStateLoaded extends WeatherdataState {
  final List<WeatherdataModel> lastFiveDaysMeasurements;
  const WeatherdataStateLoaded(this.lastFiveDaysMeasurements);
}

class WeatherdataStateLoading extends WeatherdataState {
  const WeatherdataStateLoading();
}

class WeatherdataStateError extends WeatherdataState {
  final String message;
  const WeatherdataStateError(this.message);
}
