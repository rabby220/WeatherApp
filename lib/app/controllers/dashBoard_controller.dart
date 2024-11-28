import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app/data/constant/constant.dart';
import 'package:weather_app/app/data/model/weatherModel.dart';
import 'package:weather_app/app/utils/appText.dart';

import '../services/errorMessage.dart';

class DashBoardController extends GetxController {
  //
  // Set initial temp based on saved preference
  //
  @override
  void onInit() {
    super.onInit();
    bool isFahrenheit =
        Hive.box('PeopleBox').get('switchValue', defaultValue: false);
    fetchWeather(searchCity: searchCity.value).then(
      (forecast) {
        updateTemperatureUnit(
          isFahrenheit,
          forecast,
        );
      },
    );
  }

  //Search controller
  final TextEditingController searchCityController = TextEditingController();

  // variable for City
  RxString searchCity = "auto:ip".obs;

  //  variable for temperature
  RxString temp = ''.obs;

  void updateTemperatureUnit(bool isFahrenheit, WeatherModel? weatherModel) {
    if (weatherModel == null) return; // Safety check

    temp.value = isFahrenheit
        ?
        // Convert to Fahrenheit
        "${weatherModel.current?.tempF?.round().toString() ?? ''}${AppText.fahrenheitDegreeSymbolText}"
        :
        // Convert to Celsius
        "${weatherModel.current?.tempC?.round().toString() ?? ''}${AppText.celsiusDegreeSymbolText}";
  }

  //Search box function
  void updateCity(BuildContext context) {
    if (searchCityController.text.isEmpty) {
      ErrorMessage.errorMessage(message: 'Please enter a city name');
    } else {
      searchCity.value = searchCityController.text;

      // Fetch weather for the new city and update temperature
      bool isFahrenheit =
          Hive.box('PeopleBox').get('switchValue', defaultValue: false);
      fetchWeather(searchCity: searchCity.value).then(
        (forecast) {
          updateTemperatureUnit(
              isFahrenheit, forecast); // Update temp with new data
        },
      );

      searchCityController.clear();
      Navigator.pop(context);
    }
  }

  ///
  ///  Fetch Current Weather data from apis
  ///
  ///
  Future<WeatherModel> fetchWeather({required String searchCity}) async {
    //Url
    final String url = "$WeatherUrl$searchCity&days=7";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body.toString());
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);

        // Update temperature based on the current switch setting
        bool isFahrenheit =
            Hive.box('PeopleBox').get('switchValue', defaultValue: false);
        updateTemperatureUnit(isFahrenheit, weatherModel);
        return weatherModel;
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

  ///
  ///
  ///
  ///Types of Weather background
  ///
  ///
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
