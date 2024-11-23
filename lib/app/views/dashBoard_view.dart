import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_list_view/horizontal_list_view.dart';
import 'package:weather_app/app/utils/appColor.dart';
import 'package:weather_app/app/utils/appText.dart';
import '../controllers/dashBoard_controller.dart';
import '../data/model/forecastWeatherModel.dart';
import '../services/loadingIndicator.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import '../utils/appIcon.dart';
import 'package:intl/intl.dart';

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

///Build a Widget for the current weather when user app will open the current location based weather data will shown.
Widget _buildForecastWeatherData({
  required DashBoardController controller,
  required BuildContext context,
}) {
  return FutureBuilder(
    future: controller.fetchForeCastWeather(
      searchCity: 'auto:ip',
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
            Column(
              children: [
                //City Name and Country Name
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///City Name
                      _buildTextWidget(
                          text:
                              "${forecastWeatherModel?.location?.name?.toString() ?? ""}, ",
                          textStyle: AppText.nameWithCountryTextStyle),

                      ///Country Name
                      _buildTextWidget(
                          text: forecastWeatherModel?.location?.country
                                  ?.toString() ??
                              "",
                          textStyle: AppText.nameWithCountryTextStyle),
                    ],
                  ),
                ),

                //
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      /// Current Temperature
                      _buildTextWidget(
                          text:
                              '${forecastWeatherModel?.current?.tempC!.round().toString() ?? ""}${AppText.celsiusDegreeSymbolText}',
                          textStyle: AppText.degreeTextStyle),

                      ///Time
                      _buildTextWidget(
                          text: DateFormat.MMMEd().format(DateTime.parse(
                              forecastWeatherModel?.location?.localtime
                                      ?.toString() ??
                                  "")),
                          textStyle: AppText.nameWithCountryTextStyle),

                      ///Condition of Current Weather
                      _buildTextWidget(
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
                      _buildToolTip(
                        toolMessage: 'Humidity',
                        child: _buildIconWithTextWidget(
                            iconColor: AppColor.whiteColor,
                            iconSize: 25.0,
                            icon: AppIcon.humidityIcon,
                            text:
                                "${forecastWeatherModel?.current?.humidity?.toString() ?? ""}${AppText.percentageText}"),
                      ),
                      _buildToolTip(
                        toolMessage: 'Wind',
                        child: _buildIconWithTextWidget(
                            iconColor: AppColor.whiteColor,
                            iconSize: 25.0,
                            icon: AppIcon.windSpeedIcon,
                            text:
                                "${forecastWeatherModel?.current?.windKph.toString() ?? ""} ${AppText.kiloMeterPerHourText}"),
                      ),
                      _buildToolTip(
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
                /// 24hours time based on weather view
                Expanded(
                  flex: 2,
                  child: SafeArea(
                    child: HorizontalListView.builder(
                        crossAxisCount: 3,
                        controller: HorizontalListViewController(),
                        itemCount: forecastWeatherModel
                                ?.forecast?.forecastday?[0].hour?.length ??
                            0,
                        alignment: CrossAxisAlignment.start,
                        crossAxisSpacing: 10.0,
                        itemBuilder: (_, index) {
                          Hour? hourlyWeather = forecastWeatherModel
                              ?.forecast?.forecastday?[0].hour?[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(
                              children: [
                                //24 hours time
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: _buildTextWidget(
                                      text: DateFormat.j().format(
                                          DateTime.parse(
                                              hourlyWeather?.time.toString() ??
                                                  "")),
                                      textStyle:
                                          AppText.nameWithCountryTextStyle),
                                )),

                                //Hourly Image Icon
                                Expanded(
                                  child: Image.network(
                                    "http:${hourlyWeather?.condition?.icon.toString() ?? ""}",
                                    width: 70,
                                    height: 70,
                                  ),
                                ),

                                //Hourly weather
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildToolTip(
                                      child: _buildIconWithTextWidget(
                                        icon: AppIcon.temperatureIcon,
                                        iconSize: 20.0,
                                        iconColor: AppColor.whiteColor,
                                        text:
                                            "${hourlyWeather?.tempC?.round().toString() ?? ""}${AppText.celsiusDegreeSymbolText}",
                                      ),
                                      toolMessage: '',
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            )
          ],
        );
      }

      return LoadingIndicatorIcon();
    },
  );
}

//build a alert box when user search any cities

/*search({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      });
}*/

Widget _buildTextWidget({required String text, required TextStyle textStyle}) {
  return Text(
    text,
    style: textStyle,
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

Widget _buildToolTip({required String toolMessage, required Widget child}) {
  return Tooltip(
    message: toolMessage,
    triggerMode: TooltipTriggerMode.tap,
    height: 24,
    showDuration: const Duration(milliseconds: 1000),
    textStyle: AppText.nameWithCountryTextStyle,
    child: child,
  );
}
