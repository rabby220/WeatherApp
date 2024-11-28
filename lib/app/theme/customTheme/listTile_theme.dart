import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/appText.dart';

class CustomListTileTheme {
  static ListTileThemeData lightListTileTheme = ListTileThemeData(
    titleTextStyle: AppText.lightNameWithCountryTextStyle,
    contentPadding: const EdgeInsets.all(15.0),
  );

  static ListTileThemeData darkListTileTheme = ListTileThemeData(
    titleTextStyle: AppText.nameWithCountryTextStyle,
    contentPadding: const EdgeInsets.all(15.0),
  );
}
