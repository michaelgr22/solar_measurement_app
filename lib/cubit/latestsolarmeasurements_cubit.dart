import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import 'package:solar_measurement_app/data/repositories/solar_measurements_repository.dart';

part 'latestsolarmeasurements_state.dart';

class LatestSolarMeasurementsCubit extends Cubit<LatestSolarMeasurementsState> {
  final SolarMeasurementsRepository _measurementsRepository;

  LatestSolarMeasurementsCubit(this._measurementsRepository)
      : super(LatestSolarMeasurementsInitial());

  Future<void> getLastFiveDaysMeasurements() async {
    try {
      emit(LatestSolarMeasurementsLoading());
      final lastfivedaysmeasurements =
          await _measurementsRepository.getLastFiveDaysMeasurements();
      emit(LatestSolarMeasurementsLoaded(lastfivedaysmeasurements));
    } on NetworkException {
      emit(LatestSolarMeasurementsError("Couldn't fetch data. Device online?"));
    }
  }
}
