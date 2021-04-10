part of 'latestsolarmeasurement_cubit.dart';

@immutable
abstract class LatestSolarMeasurementState {
  const LatestSolarMeasurementState();
}

class LatestSolarMeasurementInitial extends LatestSolarMeasurementState {
  const LatestSolarMeasurementInitial();
}

class LatestSolarMeasurementLoaded extends LatestSolarMeasurementState {
  final SolarMeasurementModel latestmeasurement;
  const LatestSolarMeasurementLoaded(this.latestmeasurement);
}
