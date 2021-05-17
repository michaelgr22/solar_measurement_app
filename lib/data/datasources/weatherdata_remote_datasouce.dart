import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/weatherdata_model.dart';
import '.datasources_credentails.dart';

abstract class WeatherdataRemoteDataSource {
  Future<List<WeatherdataModel>> getWeatherOfNextSevenDays(
      double lat, double lon, String units);
}

class WeatherdataRemoteDataSourceImpl implements WeatherdataRemoteDataSource {
  final String _appid = WeatherdataApiCredentials.appid;
  final String _authority = 'api.openweathermap.org';
  final String _unencodedPath = '/data/2.5/onecall';

  Future<List<WeatherdataModel>> getWeatherOfNextSevenDays(
      double lat, double lon, String units) async {
    Map<String, String> parameters = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': units,
      'appid': _appid
    };

    final Uri url = Uri.https(_authority, _unencodedPath, parameters);

    try {
      final response = await http.get(url);
      return _convertResponseToModels(response);
    } on Exception {
      throw NetworkException();
    }
  }

  List<WeatherdataModel> _convertResponseToModels(http.Response response) {
    List<WeatherdataModel> models = [];

    json.decode(response.body)['daily'].forEach((day) {
      models.add(WeatherdataModel.fromJson(day));
    });

    return models;
  }
}
