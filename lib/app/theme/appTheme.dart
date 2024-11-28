import 'package:flutter/material.dart';
import 'package:weather_app/app/theme/customTheme/appBar_theme.dart';
import 'package:weather_app/app/theme/customTheme/listTile_theme.dart';
import 'package:weather_app/app/theme/customTheme/switch_theme.dart';
import 'package:weather_app/app/utils/appColor.dart';
import 'package:weather_app/app/utils/appText.dart';

class AppTheme {
  AppTheme._();

  ///Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.whiteColor,
    textTheme: TextTheme(labelMedium: AppText.lightNameWithCountryTextStyle),
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    switchTheme: CustomSwitchTheme.lightSwitchTheme,
    listTileTheme: CustomListTileTheme.lightListTileTheme,
  );

  ///Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.blackColor,
    textTheme: TextTheme(titleMedium: AppText.nameWithCountryTextStyle),
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    switchTheme: CustomSwitchTheme.darkSwitchTheme,
    listTileTheme: CustomListTileTheme.darkListTileTheme,
  );
}
