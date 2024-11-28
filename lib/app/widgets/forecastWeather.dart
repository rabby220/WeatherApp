import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/utils/appText.dart';

import '../data/model/weatherModel.dart';

class ForecastWeather extends GetView {
  final WeatherModel? forecastWeather;
  const ForecastWeather({super.key, required this.forecastWeather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast Report'),
      ),
      body: ListView.separated(
        itemCount: forecastWeather?.forecast?.forecastday?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Forecastday? forecastday =
              forecastWeather?.forecast?.forecastday?[index];
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(DateFormat.E().format(
                      DateTime.parse(forecastday?.date?.toString() ?? ""))),
                ),
                Expanded(
                  flex: 2,
                  child:
                      Text(forecastday?.day?.condition?.text.toString() ?? ""),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                      "${forecastday?.day?.maxtempC?.round().toString() ?? ""}${AppText.celsiusDegreeSymbolText}"),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
