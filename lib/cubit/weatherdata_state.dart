part of 'weatherdata_cubit.dart';

@immutable
abstract class WeatherdataState {
  const WeatherdataState();
}

class WeatherdataStateInitial extends WeatherdataState {
  const WeatherdataStateInitial();
}

class WeatherdataStateLoaded extends WeatherdataState {
  final List<WeatherdataModel> weatherOfNextSevenDays;
  const WeatherdataStateLoaded(this.weatherOfNextSevenDays);
}

class WeatherdataStateLoading extends WeatherdataState {
  const WeatherdataStateLoading();
}

class WeatherdataStateError extends WeatherdataState {
  final String message;
  const WeatherdataStateError(this.message);
}
