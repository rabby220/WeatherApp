import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/appColor.dart';

class CustomSwitchTheme {
  CustomSwitchTheme._();

  ///Light Switch theme
  static SwitchThemeData lightSwitchTheme = const SwitchThemeData().copyWith(
    splashRadius: 15.0,
    thumbColor: WidgetStatePropertyAll(
      AppColor.blueColor,
    ),
    trackColor: WidgetStatePropertyAll(AppColor.mediumGrayColor),
  );

  //Dark Switch Theme
  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    splashRadius: 15.0,
    thumbColor: WidgetStatePropertyAll(AppColor.redColor),
    trackColor: WidgetStatePropertyAll(AppColor.mediumGrayColor),
  );
}
