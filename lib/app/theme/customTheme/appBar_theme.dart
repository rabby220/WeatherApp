import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/appColor.dart';
import 'package:weather_app/app/utils/appText.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  ///Light app bar Theme
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    toolbarHeight: 70.0,
    backgroundColor: AppColor.mediumGrayColor,
    titleTextStyle: AppText.nameWithCountryTextStyle,
    centerTitle: true,
  );

  ///Dark App bar Theme
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    toolbarHeight: 70.0,
    backgroundColor: AppColor.blackColor,
    titleTextStyle: AppText.nameWithCountryTextStyle,
    centerTitle: true,
  );
}
