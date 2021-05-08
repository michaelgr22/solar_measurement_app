import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/weatherdata_model.dart';
import 'package:solar_measurement_app/data/repositories/weatherdata_repository.dart';

part 'weatherdata_state.dart';

class WeatherdataCubit extends Cubit<WeatherdataState> {
  final WeatherDataRepository _weatherDataRepository;

  WeatherdataCubit(this._weatherDataRepository) : super(WeatherdataInitial());

  Future<void> getWeatherOfNextSevenDays(
      double lat, double lon, String units) async {
    try {
      emit(WeatherdataStateLoading());
      final lastfivedaysmeasurements = await _weatherDataRepository
          .getWeatherOfNextSevenDays(lat, lon, units);
      emit(WeatherdataStateLoaded(lastfivedaysmeasurements));
    } on NetworkException {
      emit(WeatherdataStateError("Couldn't fetch data. Device online?"));
    }
  }
}
