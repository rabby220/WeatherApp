import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/controllers/dashBoard_controller.dart';
import 'package:weather_app/app/data/model/forecastWeatherModel.dart';
import 'package:weather_app/app/utils/appIcon.dart';
import 'package:weather_app/app/widgets/searchBox.dart';

class SearchWithLocation extends StatelessWidget {
  final ForecastWeatherModel? forecastWeatherModel;
  const SearchWithLocation({super.key, required this.forecastWeatherModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///Settings Icon is here
            _buildIconButton(
              onPressed: () {
                Get.toNamed('/settings', arguments: forecastWeatherModel);
              },
              icon: Icon(
                AppIcon.settingIcon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            //Search Icon is here
            _buildIconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SearchBox();
                  },
                );
              },
              icon: Icon(
                AppIcon.searchIcon,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(
              width: 15.0,
            ),
            //Location Icon Here
            _buildIconButton(
              onPressed: () {
                DashBoardController controller = Get.put(DashBoardController());
                controller.searchCity.value = "auto:ip";
              },
              icon: Icon(
                AppIcon.currentLocationIcon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
///
///This function used for search  icon and location on icon top level.
///
///
Widget _buildIconButton({
  required VoidCallback onPressed,
  required Widget icon,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: icon,
  );
}