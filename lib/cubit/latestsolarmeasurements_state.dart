part of 'latestsolarmeasurements_cubit.dart';

@immutable
abstract class LatestSolarMeasurementsState {
  const LatestSolarMeasurementsState();
}

class LatestSolarMeasurementsInitial extends LatestSolarMeasurementsState {
  const LatestSolarMeasurementsInitial();
}

class LatestSolarMeasurementsLoaded extends LatestSolarMeasurementsState {
  final List<SolarMeasurementModel> lastFiveDaysMeasurements;
  const LatestSolarMeasurementsLoaded(this.lastFiveDaysMeasurements);
}

class LatestSolarMeasurementsLoading extends LatestSolarMeasurementsState {
  const LatestSolarMeasurementsLoading();
}

class LatestSolarMeasurementsError extends LatestSolarMeasurementsState {
  final String message;
  const LatestSolarMeasurementsError(this.message);
}
