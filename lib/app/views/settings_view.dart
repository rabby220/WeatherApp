import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/app/controllers/dashBoard_controller.dart';
import 'package:weather_app/app/controllers/settings_controller.dart';
import 'package:weather_app/app/data/model/weatherModel.dart';

import '../widgets/switch.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        toolbarHeight: 100.0,
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: _buildSettings(context: context),
    );
  }
}

Widget _buildSettings({
  required BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          ///Dark Mode Switch
          _buildListTileWidget(
            text: 'Dark Mode',
            trailing: ValueListenableBuilder(
              valueListenable: Hive.box('PeopleBox').listenable(),
              builder: (context, box, child) {
                final isDark = box.get('isDark', defaultValue: false);
                return SwitchWidget.buildSwitch(
                  value: isDark,
                  onChanged: (value) {
                    box.put('isDark', value);
                  },
                );
              },
            ),
          ),

          ///
          _buildListTileWidget(
            text: 'Temperature Unit',
            trailing: ValueListenableBuilder(
              valueListenable: Hive.box('PeopleBox').listenable(),
              builder: (context, box, child) {
                final isFahrenheit =
                    box.get('switchValue', defaultValue: false);
                return SwitchWidget.buildSwitch(
                  value: isFahrenheit,
                  onChanged: (value) {
                    box.put('switchValue', value); // Save preference in Hive

                    DashBoardController controller =
                        Get.find<DashBoardController>(); // Get controller
                    WeatherModel weatherModel =
                        Get.arguments; // Pass forecast data

                    controller.updateTemperatureUnit(
                        value, weatherModel); // Update temp
                  },
                );
              },
            ),
          ),

          _buildListTileWidget(
              text: 'App Version', trailing: const Text("1.0")),
        ],
      ),
    ),
  );
}

Widget _buildListTileWidget({required String text, required Widget trailing}) {
  return ListTile(
    title: Text(text),
    trailing: trailing,
  );
}
