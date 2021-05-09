import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/weatherdata_cubit.dart';
import 'package:solar_measurement_app/widgets/loading_progress_indicator.dart';
import 'package:solar_measurement_app/widgets/prediction_page/weather_box.dart';

class PredictionPage extends StatelessWidget {
  final lat;
  final lon;
  final units;
  PredictionPage(
      {@required this.lat, @required this.lon, @required this.units});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vorhersage"),
          backgroundColor: Color.fromRGBO(204, 154, 16, 1),
        ),
        body: BlocBuilder<WeatherdataCubit, WeatherdataState>(
            builder: (context, state) {
          Size screenSize = MediaQuery.of(context).size;
          if (state is WeatherdataStateInitial ||
              state is WeatherdataStateLoading) {
            return LoadingTableProgressIndicator();
          } else if (state is WeatherdataStateError) {
            return RefreshIndicator(
              onRefresh: () => context
                  .read<WeatherdataCubit>()
                  .getWeatherOfNextSevenDays(lat, lon, units),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Text(state.message),
                ],
              ),
            );
          } else if (state is WeatherdataStateLoaded) {
            return RefreshIndicator(
              onRefresh: () => context
                  .read<WeatherdataCubit>()
                  .getWeatherOfNextSevenDays(lat, lon, units),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.weatherOfNextSevenDays.length,
                itemBuilder: (context, index) {
                  return WeatherBox(
                    weather: state.weatherOfNextSevenDays[index],
                    screenSize: screenSize,
                  );
                },
              ),
            );
          }
          return Text('state not defined');
        }));
  }
}
