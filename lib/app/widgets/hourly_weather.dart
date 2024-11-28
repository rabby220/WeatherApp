import 'package:flutter/material.dart';
import 'package:horizontal_list_view/horizontal_list_view.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/data/model/weatherModel.dart';
import 'package:weather_app/app/widgets/text.dart';
import 'package:weather_app/app/widgets/tooltip.dart';

import '../utils/appColor.dart';
import '../utils/appIcon.dart';
import '../utils/appText.dart';

class HourlyWeatherView extends StatelessWidget {
  final WeatherModel? forecastWeatherModel;
  const HourlyWeatherView({super.key, this.forecastWeatherModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HorizontalListView.builder(
        crossAxisCount: 3,
        controller: HorizontalListViewController(),
        itemCount:
            forecastWeatherModel?.forecast?.forecastday?[0].hour?.length ?? 0,
        alignment: CrossAxisAlignment.start,
        crossAxisSpacing: 10.0,
        itemBuilder: (_, index) {
          Hour? hourlyWeather =
              forecastWeatherModel?.forecast?.forecastday?[0].hour?[index];
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
                    child: TextWidget.buildTextWidget(
                      text: DateFormat.j().format(
                          DateTime.parse(hourlyWeather?.time.toString() ?? "")),
                      textStyle: AppText.nameWithCountryTextStyle,
                    ),
                  ),
                ),

                //Hourly Image Icon
                Expanded(
                  child: CircleAvatar(
                    maxRadius: 22,
                    backgroundColor: AppColor.blueColor,
                    child: Image.network(
                      "http:${hourlyWeather?.condition?.icon.toString() ?? ""}",
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),

                //Hourly weather
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToolTipWidget.buildToolTip(
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
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
