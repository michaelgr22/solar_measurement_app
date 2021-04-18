import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import 'package:solar_measurement_app/data/repositories/solar_measurements_repository.dart';

part 'latestsolarmeasurement_state.dart';

class LatestSolarMeasurementCubit extends Cubit<LatestSolarMeasurementState> {
  final SolarMeasurementsRepository _measurementsRepository;

  LatestSolarMeasurementCubit(this._measurementsRepository)
      : super(LatestSolarMeasurementInitial());

  Future<void> getLatestSolarMeasurement() async {
    try {
      emit(LatestSolarMeasurementLoading());
      final latestmeasurement =
          await _measurementsRepository.getLatestMeasurement();
      emit(LatestSolarMeasurementLoaded(latestmeasurement));
    } on NetworkException {
      emit(LatestSolarMeasurementError("Couldn't fetch data. Device online?"));
    }
  }
}
