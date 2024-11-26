import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app/data/constant/constant.dart';
import 'package:weather_app/app/data/model/forecastWeatherModel.dart';
import 'package:weather_app/app/utils/appText.dart';

import '../services/errorMessage.dart';

class DashBoardController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    bool isFahrenheit =
        Hive.box('PeopleBox').get('switchValue', defaultValue: false);
    fetchForeCastWeather(searchCity: searchCity.value).then((forecast) {
      updateTemperatureUnit(
          isFahrenheit, forecast); // Set initial temp based on saved preference
    });
  }

  final TextEditingController searchCityController = TextEditingController();

  RxString searchCity = "auto:ip".obs; // Observable variable for City
  RxString temp = ''.obs; // Observable variable for temperature

  void updateTemperatureUnit(
      bool isFahrenheit, ForecastWeatherModel? forecast) {
    if (forecast == null) return; // Safety check

    temp.value = isFahrenheit
        ? "${forecast.current?.tempF?.round()?.toString() ?? ''}${AppText.fahrenheitDegreeSymbolText}" // Convert to Fahrenheit
        : "${forecast.current?.tempC?.round()?.toString() ?? ''}${AppText.celsiusDegreeSymbolText}"; // Convert to Celsius
  }

  void updateCity(BuildContext context) {
    if (searchCityController.text.isEmpty) {
      ErrorMessage.errorMessage(message: 'Please enter a city name');
    } else {
      searchCity.value = searchCityController.text;
      searchCityController.clear();
      Navigator.pop(context);

      // Fetch weather for the new city and update temperature
      bool isFahrenheit =
          Hive.box('PeopleBox').get('switchValue', defaultValue: false);
      fetchForeCastWeather(searchCity: searchCity.value).then((forecast) {
        updateTemperatureUnit(
            isFahrenheit, forecast); // Update temp with new data
      });
    }
  }

  ///
  ///  Fetch Current Weather data from apis
  ///
  ///
  Future<ForecastWeatherModel> fetchForeCastWeather(
      {required String searchCity}) async {
    //Url
    final String url = "$foreCastWeatherUrl$searchCity&days=7";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body.toString());
        ForecastWeatherModel forecastWeatherModel =
            ForecastWeatherModel.fromJson(jsonData);

        // Update temperature based on the current switch setting
        bool isFahrenheit =
            Hive.box('PeopleBox').get('switchValue', defaultValue: false);
        updateTemperatureUnit(isFahrenheit, forecastWeatherModel);
        return forecastWeatherModel;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> errorData = jsonDecode(response.body.toString());
        String errorMessage =
            errorData['error']['message'] ?? 'An unexpected error occurred';
        ErrorMessage.errorMessage(message: errorMessage);
        throw Exception(errorMessage);
      } else {
        throw [];
      }
    } catch (e) {
      throw Exception('catch error $e');
    }
  }

  ///Types of Weather background
  WeatherType getWeatherBackground(Current? current) {
    String? weatherConditionText = current?.condition?.text?.toLowerCase();

    /////When day is 1 show will the weather background
    if (current?.isDay == 1) {
      if (weatherConditionText == "sunny") {
        return WeatherType.sunny;
      } else if (weatherConditionText == "partly cloudy") {
        return WeatherType.cloudy;
      } else if (weatherConditionText == "cloudy") {
        return WeatherType.cloudy;
      } else if (weatherConditionText == "overcast") {
        return WeatherType.overcast;
      } else if (weatherConditionText == "mist") {
        return WeatherType.foggy;
      } else if (weatherConditionText == "patchy rain possible") {
        return WeatherType.lightRainy;
      } else if (weatherConditionText == "heavy rain at times") {
        return WeatherType.heavyRainy;
      } else if (weatherConditionText == "patchy light rain with thunder") {
        return WeatherType.thunder;
      } else {
        return WeatherType.sunny;
      }
    }

    ///When day is 0 show will the weather background
    else {
      if (weatherConditionText == "clear") {
        return WeatherType.sunnyNight;
      } else if (weatherConditionText == "cloudy") {
        return WeatherType.cloudy;
      } else if (weatherConditionText == "cloudy") {
        return WeatherType.cloudy;
      } else if (weatherConditionText == "overcast") {
        return WeatherType.overcast;
      } else if (weatherConditionText == "mist") {
        return WeatherType.foggy;
      } else if (weatherConditionText == "patchy rain possible") {
        return WeatherType.lightRainy;
      } else if (weatherConditionText == "heavy rain at times") {
        return WeatherType.heavyRainy;
      } else {
        return WeatherType.sunnyNight;
      }
    }
  }
}
