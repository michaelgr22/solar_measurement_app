import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

part 'latestsolarmeasurement_state.dart';

class LatestSolarMeasurementCubit extends Cubit<LatestSolarMeasurementState> {
  final SolarMeasurementsRemoteDataSoruce _solarMeasurementsRemoteDataSoruce;

  LatestSolarMeasurementCubit(this._solarMeasurementsRemoteDataSoruce)
      : super(LatestSolarMeasurementInitial());

  Future<void> getLatestSolarMeasurement() async {
    final latestmeasurement =
        await _solarMeasurementsRemoteDataSoruce.getLatestMeasurement();
    emit(LatestSolarMeasurementLoaded(latestmeasurement));
  }
}
