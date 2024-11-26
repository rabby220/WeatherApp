import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/utils/appColor.dart';
import 'package:weather_app/app/utils/appText.dart';

import '../controllers/dashBoard_controller.dart';
import '../data/model/forecastWeatherModel.dart';
import '../services/loadingIndicator.dart';
import '../utils/appIcon.dart';
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
      future: controller.fetchForeCastWeather(
        searchCity: controller.searchCity.value,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ForecastWeatherModel? forecastWeatherModel = snapshot.data;
          return Stack(
            children: [
              WeatherBg(
                weatherType: controller
                    .getWeatherBackground(forecastWeatherModel?.current),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),

              ///search Icon and Location On Icon Here with Alert Box when user search any location..
              ///
              ///
              SearchWithLocation(
                forecastWeatherModel: forecastWeatherModel,
              ),

              ///
              ///
              ///
              ///
              Column(
                children: [
                  //City Name and Country Name Here
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///City Name
                        TextWidget.buildTextWidget(
                            text:
                                "${forecastWeatherModel?.location?.name?.toString() ?? ""}, ",
                            textStyle: AppText.nameWithCountryTextStyle),

                        ///Country Name
                        TextWidget.buildTextWidget(
                            text: forecastWeatherModel?.location?.country
                                    ?.toString() ??
                                "",
                            textStyle: AppText.nameWithCountryTextStyle),
                      ],
                    ),
                  ),

                  //
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        /// Current Temperature
                        Obx(
                          () => TextWidget.buildTextWidget(
                              text: "${controller.temp.value}",
                              textStyle: AppText.degreeTextStyle),
                        ),

                        ///Time
                        TextWidget.buildTextWidget(
                            text: DateFormat.MMMEd().format(DateTime.parse(
                                forecastWeatherModel?.location?.localtime
                                        ?.toString() ??
                                    "")),
                            textStyle: AppText.nameWithCountryTextStyle),

                        ///Condition of Current Weather
                        TextWidget.buildTextWidget(
                            text: forecastWeatherModel?.current?.condition!.text
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
                                  "${forecastWeatherModel?.current?.humidity?.toString() ?? ""}${AppText.percentageText}"),
                        ),
                        ToolTipWidget.buildToolTip(
                          toolMessage: 'Wind',
                          child: _buildIconWithTextWidget(
                              iconColor: AppColor.whiteColor,
                              iconSize: 25.0,
                              icon: AppIcon.windSpeedIcon,
                              text:
                                  "${forecastWeatherModel?.current?.windKph.toString() ?? ""} ${AppText.kiloMeterPerHourText}"),
                        ),
                        ToolTipWidget.buildToolTip(
                          toolMessage: 'Feels Like',
                          child: _buildIconWithTextWidget(
                              iconColor: AppColor.whiteColor,
                              iconSize: 25.0,
                              icon: AppIcon.feelsLikeIcon,
                              text:
                                  "${forecastWeatherModel?.current?.feelslikeC.toString() ?? ""} ${AppText.celsiusDegreeSymbolText}"),
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// 24hours time based weather view
                  ///
                  Expanded(
                    flex: 2,
                    child: HourlyWeatherView(
                        forecastWeatherModel: forecastWeatherModel),
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
