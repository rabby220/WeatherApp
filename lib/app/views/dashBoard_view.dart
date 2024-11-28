import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/data/model/weatherModel.dart';
import 'package:weather_app/app/utils/appColor.dart';
import 'package:weather_app/app/utils/appText.dart';

import '../controllers/dashBoard_controller.dart';
import '../services/loadingIndicator.dart';
import '../utils/appIcon.dart';
import '../widgets/forecastWeather.dart';
import '../widgets/hourly_weather.dart';
import '../widgets/searchWithLocation.dart';
import '../widgets/text.dart';
import '../widgets/tooltip.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForecastWeatherData(
        controller: controller,
        context: context,
      ),
    );
  }
}

//Build a Widget for the current weather when user app will open the current location based weather data will shown.
Widget _buildForecastWeatherData({
  required DashBoardController controller,
  required BuildContext context,
}) {
  return Obx(
    () => FutureBuilder(
      future: controller.fetchWeather(
        searchCity: controller.searchCity.value,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WeatherModel? weatherModel = snapshot.data;
          return Stack(
            children: [
              WeatherBg(
                weatherType:
                    controller.getWeatherBackground(weatherModel?.current),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),

              ///
              Column(
                children: [
                  ///search Icon and Location On Icon Here with Alert Box when user search any location..
                  ///
                  ///
                  ///
                  Expanded(
                    flex: 1,
                    child: SearchWithLocation(
                      weatherModel: weatherModel,
                    ),
                  ),

                  //
                  //
                  //City Name and Country Name Here
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///
                        ///
                        ///
                        ///City Name
                        TextWidget.buildTextWidget(
                            text:
                                "${weatherModel?.location?.name?.toString() ?? ""}, ",
                            textStyle: AppText.nameWithCountryTextStyle1),

                        ///Country Name
                        ///
                        ///
                        TextWidget.buildTextWidget(
                            text: weatherModel?.location?.country?.toString() ??
                                "",
                            textStyle: AppText.nameWithCountryTextStyle1),
                      ],
                    ),
                  ),

                  //
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        /// Current Temperature
                        Obx(
                          () => TextWidget.buildTextWidget(
                              text: controller.temp.value,
                              textStyle: AppText.degreeTextStyle),
                        ),

                        ///Time
                        TextWidget.buildTextWidget(
                            text: DateFormat.MMMEd().format(DateTime.parse(
                                weatherModel?.location?.localtime?.toString() ??
                                    "")),
                            textStyle: AppText.nameWithCountryTextStyle),

                        ///Condition of Current Weather
                        TextWidget.buildTextWidget(
                            text: weatherModel?.current?.condition!.text
                                    .toString() ??
                                "",
                            textStyle: AppText.nameWithCountryTextStyle),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ToolTipWidget.buildToolTip(
                          toolMessage: 'Humidity',
                          child: _buildIconWithTextWidget(
                              iconColor: AppColor.whiteColor,
                              iconSize: 25.0,
                              icon: AppIcon.humidityIcon,
                              text:
                                  "${weatherModel?.current?.humidity?.toString() ?? ""}${AppText.percentageText}"),
                        ),
                        ToolTipWidget.buildToolTip(
                          toolMessage: 'Wind',
                          child: _buildIconWithTextWidget(
                              iconColor: AppColor.whiteColor,
                              iconSize: 25.0,
                              icon: AppIcon.windSpeedIcon,
                              text:
                                  "${weatherModel?.current?.windKph.toString() ?? ""} ${AppText.kiloMeterPerHourText}"),
                        ),
                        ToolTipWidget.buildToolTip(
                          toolMessage: 'Feels Like',
                          child: _buildIconWithTextWidget(
                              iconColor: AppColor.whiteColor,
                              iconSize: 25.0,
                              icon: AppIcon.feelsLikeIcon,
                              text:
                                  "${weatherModel?.current?.feelslikeC.toString() ?? ""} ${AppText.celsiusDegreeSymbolText}"),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          () => ForecastWeather(forecastWeather: weatherModel),
                        );
                      },
                      child: Text(
                        'See Forecast',
                        style: AppText.nameWithCountryTextStyle,
                      ),
                    ),
                  ),

                  ///
                  ///
                  /// 24hours time based weather view
                  ///
                  Expanded(
                    flex: 2,
                    child:
                        HourlyWeatherView(forecastWeatherModel: weatherModel),
                  ),
                ],
              ),
            ],
          );
        }

        return LoadingIndicatorIcon();
      },
    ),
  );
}

//build for icon and text showing such ad temperature, humidity, wind
Widget _buildIconWithTextWidget(
    {required IconData icon,
    required String text,
    double? iconSize,
    Color? iconColor}) {
  return Row(
    children: [
      Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      const SizedBox(
        width: 5.0,
      ),
      Text(
        text,
        style: AppText.nameWithCountryTextStyle,
      ),
    ],
  );
}
